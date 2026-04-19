import SwiftUI

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

#Preview {
    HStack {
        TimeUnitView(value: 12, label: "m")
        TimeUnitView(value: 0, label: "s")
    }
    .padding()
    .background(Color.black)
    .preferredColorScheme(.dark)
}
