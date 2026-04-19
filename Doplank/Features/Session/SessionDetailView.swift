//
//  SessionDetailView.swift
//  Doplank
//

import SwiftUI

// MARK: - Main View

struct SessionDetailView: View {
    let result: SessionResult
    var onDone: (() -> Void)? = nil

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                
                // Section 1: Total Time
                VStack(alignment: .leading, spacing: 8) {
                    Text("Session Result")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.leading, 16)
                    
                    TotalTimeCardView(totalSeconds: result.totalSeconds)
                        .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
                }

                // Section 2: Breakdown
                VStack(spacing: 0) {
                    BreakdownRowView(
                        seconds: result.stableSeconds,
                        label: "Stable Hold",
                        color: .green,
                        isDimmed: false
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 12)

                    Divider()
                        .padding(.leading, 16)

                    BreakdownRowView(
                        seconds: result.breakSeconds,
                        label: "Form Break",
                        color: .orange,
                        isDimmed: true
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 12))
            }
            .padding(.top, 16)
            .padding(.horizontal)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle(formatDate(result.date))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            if let onDone {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        onDone()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            AppOrientation.unlockToDefault()
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyyhh:mma"
        return formatter.string(from: date)
    }
}

// MARK: - Subviews

struct TotalTimeCardView: View {
    let totalSeconds: Int
    
    var body: some View {
        VStack(spacing: 12) {
            Text("You've been plank for")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(alignment: .lastTextBaseline, spacing: 12) {
                TimeUnitView(value: totalSeconds / 60, label: "m")
                TimeUnitView(value: totalSeconds % 60, label: "s")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}

struct TimeUnitView: View {
    let value: Int
    let label: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 3) {
            Text(String(format: "%02d", value))
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .monospacedDigit()

            Text(label)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.secondary)
        }
    }
}

struct BreakdownRowView: View {
    let seconds: Int
    let label: String
    let color: Color
    let isDimmed: Bool
    
    var body: some View {
        HStack {
            HStack(alignment: .lastTextBaseline, spacing: 3) {
                Text("\(seconds)")
                    .font(.title.bold().monospacedDigit())
                    .foregroundStyle(isDimmed ? .secondary : .primary)

                Text("s")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(label)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(color)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

#Preview("Session Detail") {
    NavigationStack {
        // Dummy data ditulis langsung (inline) di sini agar lebih mudah dipahami & diubah nilainya
        SessionDetailView(
            result: SessionResult(date: Date(), totalSeconds: 58, stableSeconds: 54, breakSeconds: 4),
            onDone: {}
        )
    }
    .preferredColorScheme(.dark)
}
