import SwiftUI

struct TotalTimeCardView: View {
    let totalSeconds: Int
    
    var body: some View {
        VStack {
            Text("You've been plank for")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            HStack(alignment: .lastTextBaseline, spacing: 12) {
                TimeUnitView(value: totalSeconds / 60, label: "m")
                TimeUnitView(value: totalSeconds % 60, label: "s")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
}

#Preview {
    TotalTimeCardView(totalSeconds: 58)
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
        .preferredColorScheme(.dark)
}
