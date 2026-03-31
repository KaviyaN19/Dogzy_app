import SwiftUI

struct RootView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome: Bool = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false

    var body: some View {
        Group {
            if !hasSeenOnboarding {
                // Onboarding should set hasSeenOnboarding = true when finished
                OnboardingScreen()
            } else if !hasSeenWelcome {
                // Welcome screen should set hasSeenWelcome = true when "Get Started" tapped
                WelcomeScreen()
            } else if !isLoggedIn {
                // Login screen should set isLoggedIn = true on successful login
                LoginScreen()
            } else {
                // Main app tab view after login
                MainTabView()
            }
        }
        .animation(.easeInOut, value: hasSeenOnboarding)
        .animation(.easeInOut, value: hasSeenWelcome)
        .animation(.easeInOut, value: isLoggedIn)
    }
}
#Preview{
    RootView()
}
