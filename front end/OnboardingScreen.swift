import SwiftUI

struct OnboardingScreen: View {
    // animation state
    @State private var animate = false

    // single source-of-truth navigation flag
    // when set true we attempt to navigate (either push or modal)
    @State private var navigateRequested = false

    // protect from double presentation
    @State private var hasNavigated = false

    // timeout in seconds
    private let delaySeconds: UInt64 = 5

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color(red: 0.6, green: 0.94, blue: 0.99),
                    Color(red: 0.8, green: 0.78, blue: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            Ellipse()
                .fill(Color.white)
                .frame(width: 260, height: 180)
                .shadow(radius: 4)

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .scaleEffect(animate ? 1.0 : 0.3)
                .opacity(animate ? 1.0 : 0.0)
                .animation(.spring(response: 0.6, dampingFraction: 0.65).delay(0.2), value: animate)

            // Top-right Skip button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        requestNavigate()
                    }) {
                        Text("Skip")
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.9)))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 44)
                    .padding(.trailing, 18)
                }
                Spacer()
            }

            // Hidden NavigationLink — works if OnboardingScreen is inside NavigationStack
            NavigationLink(
                destination: WelcomeScreen()
                    .navigationBarBackButtonHidden(true),
                isActive: Binding(
                    get: { navigateRequested && !hasNavigated && isInsideNavigationStack() },
                    set: { newVal in
                        if newVal {
                            // mark that navigation happened so we don't present twice
                            hasNavigated = true
                        }
                        // do not change navigateRequested here (we use navigateRequested to control fullScreenCover too)
                    }
                )
            ) {
                EmptyView()
            }
            .hidden()

            // fullScreenCover fallback — works even if there is no NavigationStack
            .fullScreenCover(isPresented: Binding(
                get: { navigateRequested && !hasNavigated && !isInsideNavigationStack() },
                set: { newVal in
                    if newVal {
                        hasNavigated = true
                    }
                }
            )) {
                // Show welcome as a modal when NavigationStack push isn't active.
                WelcomeScreen()
            }

            // DEBUG: tiny test button bottom-left (you can remove)
            VStack {
                Spacer()
                
            }
        }
        .onAppear {
            animate = true
            startAutoNavigateTask()
        }
        .navigationBarHidden(true)
    }

    // MARK: - Helpers

    // central request routine (idempotent)
    private func requestNavigate() {
        guard !hasNavigated else { return }
        navigateRequested = true
    }

    // start a Task-based timer that requests navigation after delaySeconds
    private func startAutoNavigateTask() {
        Task {
            // sleep accepts nanoseconds
            try? await Task.sleep(nanoseconds: delaySeconds * 1_000_000_000)
            // If task not cancelled, request navigation
            if !Task.isCancelled {
                await MainActor.run {
                    requestNavigate()
                }
            }
        }
    }

    // heuristic to detect whether view sits inside a NavigationStack.
    // There's no official public API to detect this, so we use a best-effort approach:
    // create a UINavigationController lookup—if found, assume NavigationStack/NavigationView present.
    // This is conservative: if detection fails, the fullScreenCover fallback will show the destination.
    private func isInsideNavigationStack() -> Bool {
        // Try to find a UINavigationController in the responder chain / scenes
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = scene.windows.first {
                var responder: UIResponder? = window.rootViewController
                while let r = responder {
                    if r is UINavigationController { return true }
                    responder = r.next
                }
            }
        }
        return false
    }
}


#Preview {
    OnboardingScreen()
}
