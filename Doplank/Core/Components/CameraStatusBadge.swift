//
//  CameraStatusBadge.swift
//  Doplank
//

import SwiftUI

/// Status badge pill shown at bottom of camera screen during active session.
/// Matches the "● Timer started, hold your position" style from mockup.
struct CameraStatusBadge: View {
    let message: String
    var dotColor: Color = .green

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(dotColor)
                .frame(width: 8, height: 8)

            Text(message)
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.black.opacity(0.45), in: Capsule())
        .accessibilityLabel(message)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        VStack(spacing: 12) {
            CameraStatusBadge(message: "Timer started, hold your position")
            CameraStatusBadge(message: "Session paused", dotColor: .orange)
        }
    }
}
