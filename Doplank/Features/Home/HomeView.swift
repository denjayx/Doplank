//
//  HomeView.swift
//  Doplank
//
//  Created by Deni Wijaya on 17/04/26.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("hideLandscapeNotice") private var hideLandscapeNotice = false

    @State private var isSessionActive = false
    @State private var showLandscapeNotice = false

    @State private var showResult = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "figure.core.training")
                    .font(.system(size: 80))
                    .foregroundStyle(Color.orangeBrand)

                VStack(spacing: 8) {
                    Text("Ready for today's plank?")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("For best experience, place your phone in landscape before starting.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Button(action: handleOpenCameraTapped) {
                    Label("Open Camera", systemImage: "camera.viewfinder")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.glassProminent)
                .controlSize(.large)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                .tint(.orangeBrand)
            }
            .fullScreenCover(isPresented: $isSessionActive) {
                CameraSessionView(onComplete: {
                    showResult = true
                })
            }
            .navigationDestination(isPresented: $showResult) {
                SessionDetailView(result: .preview, onDone: {
                    showResult = false
                })
            }
            .alert("Use Landscape Mode", isPresented: $showLandscapeNotice) {
                Button("Not Now", role: .cancel) {}

                Button("Don't Show Again") {
                    hideLandscapeNotice = true
                    openCamera()
                }

                Button("Continue") {
                    openCamera()
                }
            } message: {
                Text("This session works best in landscape. Rotate your phone after opening the camera.")
            }
        }
    }

    private func handleOpenCameraTapped() {
        if hideLandscapeNotice {
            openCamera()
        } else {
            showLandscapeNotice = true
        }
    }

    private func openCamera() {
        AppOrientation.lockLandscape()
        // Small delay to let orientation lock settle before presenting
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            isSessionActive = true
        }
    }
}

#Preview {
    HomeView()
}
