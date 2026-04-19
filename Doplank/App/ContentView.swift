import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        NavigationStack {
            if hasSeenOnboarding {
                RootTabView()
                    .preferredColorScheme(.dark)
            } else {
                OnboardingView(onGetStarted: {
                    hasSeenOnboarding = true
                })
                .preferredColorScheme(.dark)
            }
        }
    }
}

#Preview {
    ContentView()
}
