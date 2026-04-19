import SwiftUI

struct SessionMetricRowView: View {
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
        .padding(6)
    }
}

#Preview {
    VStack {
        SessionMetricRowView(seconds: 54, label: "Stable Hold", color: .green, isDimmed: false)
        SessionMetricRowView(seconds: 4, label: "Form Break", color: .orange, isDimmed: true)
    }
    .padding()
    .cardStyle()
    .preferredColorScheme(.dark)
}
