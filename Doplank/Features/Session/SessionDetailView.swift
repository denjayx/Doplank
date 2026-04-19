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
                        .cardStyle()
                }

                // Section 2: Breakdown
                VStack(spacing: 0) {
                    SessionMetricRowView(
                        seconds: result.stableSeconds,
                        label: "Stable Hold",
                        color: .green,
                        isDimmed: false
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 12)

                    Divider()
                        .padding(.leading, 16)

                    SessionMetricRowView(
                        seconds: result.breakSeconds,
                        label: "Form Break",
                        color: .orange,
                        isDimmed: true
                    )
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                .cardStyle()
            }
            .padding(.top, 16)
            .padding(.horizontal)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
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
        formatter.dateFormat = "d MMM yyyy, HH:mm"
        return formatter.string(from: date)
    }
}

// MARK: - Preview

#Preview("Session Detail") {
    NavigationStack {
        SessionDetailView(
            result: SessionResult(date: Date(), totalSeconds: 58, stableSeconds: 54, breakSeconds: 4),
            onDone: {}
        )
    }
    .preferredColorScheme(.dark)
}
