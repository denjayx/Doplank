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
            VStack(spacing: 12) {

                // Date Title (Custom Large Title)
                HStack {
                    Text(formatDate(result.date))
						.frame(maxWidth: .infinity)
                        .font(.title.bold())
						.padding(.bottom, 16)
                    Spacer()
                }

                // Section 1: Total Time
                VStack(alignment: .leading, spacing: 8) {
                    TotalTimeCardView(totalSeconds: result.totalSeconds)
                        .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
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
                .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 20))
            }
            .padding(.top, 16)
            .padding(.horizontal)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Ini akan selalu diam di tengah atas (inline)
            ToolbarItem(placement: .principal) {
                Text("Session Result")
					.font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            
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
        // Format cantik & pendek: "14 Apr 2026 • 15:20" atau "Apr 14 • 03:20 PM"
        formatter.dateFormat = "d MMM yyyy, HH:mm"
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
        HStack(spacing: 2) {
            Text(String(format: "%02d", value))
                .font(.system(size: 56).bold())
            
            Text(label)
                .font(.title2)
        }
        .opacity(value == 0 ? 0.4 : 1.0)
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
