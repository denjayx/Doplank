//
//  CameraSessionView.swift
//  Doplank
//

import SwiftUI

// MARK: - Session State

enum CameraSessionState {
    case idle
    case running
    case paused
}

// MARK: - Main View

struct CameraSessionView: View {
    @Environment(\.dismiss) private var dismiss

    var onComplete: (() -> Void)? = nil

    @State private var sessionState: CameraSessionState = .idle
    @State private var totalSeconds: Int = 0
    @State private var timer: Timer?

    private var isPaused: Bool { sessionState == .paused }

    var body: some View {
        ZStack {
            // Live camera background
            CameraPreviewView()
                .ignoresSafeArea()

            // Dim overlay
            Color.black.opacity(0.2)
                .ignoresSafeArea()

            // UI layer
            VStack(spacing: 0) {
                topBar
                Spacer()
                centerContent
                Spacer()
                bottomContent
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 20)
        }
        .statusBarHidden(true)
        // Native iOS 26 alert — automatic liquid glass appearance
        .alert("Paused", isPresented: .init(
            get: { isPaused },
            set: { if !$0 { continueSession() } }
        )) {
            Button("Continue") {
                continueSession()
            }
            Button("End Session", role: .destructive) {
                endSession()
            }
        } message: {
            Text("We can't detect a plank position. Get back into position to continue, or end your session.")
        }
        .onDisappear {
            stopTimer()
            AppOrientation.unlockToDefault()
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack {
            closeButton
            Spacer()
            TimerChip(totalSeconds: totalSeconds)
            Spacer()
            closeButton.hidden()
        }
    }

    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 36, height: 36)
                .background(.black.opacity(0.45), in: Circle())
        }
        .accessibilityLabel("Close camera session")
    }

    // MARK: - Center Content

    @ViewBuilder
    private var centerContent: some View {
        switch sessionState {
        case .idle:
            idleCard
        case .running, .paused:
            EmptyView()
        }
    }

    // MARK: - Bottom Content

    @ViewBuilder
    private var bottomContent: some View {
        switch sessionState {
        case .idle:
            Button {
                startSession()
            } label: {
                Label("Start Session", systemImage: "play.fill")
                    .font(.headline)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .tint(.orangeBrand)

        case .running:
            VStack(spacing: 16) {
                CameraStatusBadge(message: "Timer started, hold your position")

                Button {
                    pauseSession()
                } label: {
                    Label("Pause", systemImage: "pause.fill")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.white.opacity(0.85))
                }
                .accessibilityLabel("Pause session")
            }

        case .paused:
            EmptyView()
        }
    }

    // MARK: - Idle Card

    private var idleCard: some View {
        VStack(spacing: 6) {
            Text("Get into plank position to start.")
                .font(.headline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text("Timer will start automatically with a sound cue.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(.black.opacity(0.45), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    // MARK: - Session Control

    private func startSession() {
        sessionState = .running
        startTimer()
    }

    private func pauseSession() {
        sessionState = .paused
        stopTimer()
    }

    private func continueSession() {
        sessionState = .running
        startTimer()
    }

    private func endSession() {
        stopTimer()
        onComplete?()
        dismiss()
    }

    // MARK: - Timer

    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            totalSeconds += 1
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    CameraSessionView()
        .preferredColorScheme(.dark)
}
