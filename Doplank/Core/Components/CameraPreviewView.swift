//
//  CameraPreviewView.swift
//  Doplank
//
//  Created by Deni Wijaya on 18/04/26.
//

import SwiftUI
import AVFoundation
import Combine
import UIKit

/// Clean full-bleed camera preview surface for prototype/simulation.
/// - Uses AVFoundation directly (no system camera chrome)
/// - Suitable for custom overlays in landscape UI
/// - No tracking/ML logic included
struct CameraPreviewView: View {
    @StateObject private var manager = CameraPreviewManager()

    var body: some View {
        CameraSessionPreview(session: manager.session)
            .ignoresSafeArea()
            .task {
                await manager.prepare()
            }
            .onDisappear {
                manager.stop()
            }
    }
}

// MARK: - Session Manager

@MainActor
final class CameraPreviewManager: ObservableObject {
    @Published var authorizationState: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

    let session = AVCaptureSession()
    private var configured = false

    func prepare() async {
        switch authorizationState {
        case .authorized:
            configureAndStartIfNeeded()

        case .notDetermined:
            let granted = await requestPermission()
            authorizationState = AVCaptureDevice.authorizationStatus(for: .video)
            if granted {
                configureAndStartIfNeeded()
            }

        case .denied, .restricted:
            break

        @unknown default:
            break
        }
    }

    func stop() {
        Task.detached { [session] in
            guard session.isRunning else { return }
            session.stopRunning()
        }
    }

    private func requestPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .video) { granted in
                continuation.resume(returning: granted)
            }
        }
    }

    private func configureAndStartIfNeeded() {
        if !configured {
            configureSession()
            configured = true
        }

        Task.detached { [session] in
            guard !session.isRunning else { return }
            session.startRunning()
        }
    }

    private func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .high

        defer {
            session.commitConfiguration()
        }

        for input in session.inputs {
            session.removeInput(input)
        }

        guard
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let input = try? AVCaptureDeviceInput(device: camera),
            session.canAddInput(input)
        else {
            return
        }

        session.addInput(input)
    }
}

// MARK: - UIKit bridge

private struct CameraSessionPreview: UIViewRepresentable {
    let session: AVCaptureSession

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.previewLayer.videoGravity = .resizeAspectFill
        view.previewLayer.session = session

        // Observe when session actually starts running — that's the earliest
        // moment the connection exists and videoRotationAngle can be set.
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(Coordinator.sessionDidStartRunning(_:)),
            name: AVCaptureSession.didStartRunningNotification,
            object: session
        )

        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        if uiView.previewLayer.session !== session {
            uiView.previewLayer.session = session
        }
        context.coordinator.previewView = uiView
        // Try immediately in case connection is already ready.
        uiView.applyLandscapeRotation()
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

    final class Coordinator: NSObject {
        weak var previewView: PreviewView?

        @objc func sessionDidStartRunning(_ notification: Notification) {
            // Connection is guaranteed ready here — apply from main thread.
            DispatchQueue.main.async {
                self.previewView?.applyLandscapeRotation()
            }
        }
    }
}

private final class PreviewView: UIView {
    override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }

    var previewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected AVCaptureVideoPreviewLayer")
        }
        return layer
    }

    /// Apply rotation to match a locked-landscape UI.
    /// UI is always landscapeRight → AVFoundation angle 0 = natural preview.
    func applyLandscapeRotation() {
        guard
            let connection = previewLayer.connection,
            connection.isVideoRotationAngleSupported(0)
        else { return }
        connection.videoRotationAngle = 0
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
        // Re-apply every layout pass — handles cases where connection
        // is established after the first layout (e.g. session late start).
        applyLandscapeRotation()
    }
}

#Preview {
    CameraPreviewView()
        .preferredColorScheme(.dark)
}
