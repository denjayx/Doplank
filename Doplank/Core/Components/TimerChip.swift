//
//  TimerChip.swift
//  Doplank
//

import SwiftUI

/// Reusable timer chip matching the "00m 00s" pill style from mockup.
struct TimerChip: View {
    let totalSeconds: Int

    private var minutes: Int { totalSeconds / 60 }
    private var seconds: Int { totalSeconds % 60 }

    var body: some View {
        HStack(spacing: 6) {
            timeUnit(value: minutes, label: "m")
            timeUnit(value: seconds, label: "s")
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(.black.opacity(0.45), in: Capsule())
        .accessibilityLabel("\(minutes) minutes \(seconds) seconds")
    }

    private func timeUnit(value: Int, label: String) -> some View {
        HStack(alignment: .lastTextBaseline, spacing: 1) {
            Text(String(format: "%02d", value))
                .font(.system(.title2, design: .rounded).weight(.semibold).monospacedDigit())
                .foregroundStyle(.white)

            Text(label)
                .font(.system(.footnote, design: .rounded).weight(.semibold))
                .foregroundStyle(.white.opacity(0.75))
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 16) {
            TimerChip(totalSeconds: 0)
            TimerChip(totalSeconds: 62)
            TimerChip(totalSeconds: 3661)
        }
    }
}
