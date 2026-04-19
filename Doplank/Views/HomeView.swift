//
//  HomeView.swift
//  Doplank
//
//  Created by Deni Wijaya on 17/04/26.
//

import SwiftUI

struct HomeView: View {
    // State sakelar untuk memunculkan layar kamera
    @State private var isSessionActive = false

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "figure.core.training")
                .font(.system(size: 80))
                .foregroundStyle(Color.orangeBrand)
            VStack(spacing: 8) {
                Text("Ready for today's plank?")
                    .font(.title2)
                    .fontWeight(.bold)

                Text(
                    "Get into position. The timer will start automatically when your form is correct."
                )
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            }
            Button(action: {
                isSessionActive = true
            }) {
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
            CameraSessionView()
        }
    }
}

#Preview {
    HomeView()
}
