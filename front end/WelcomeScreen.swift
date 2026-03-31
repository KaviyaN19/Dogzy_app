import SwiftUI

struct WelcomeScreen: View {
    @State private var navigateToLogin = false

    var body: some View {
        // Using NavigationStack here so the Get Started button does a push
        NavigationStack {
            ZStack {
                // 1️⃣ Gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.6, green: 0.94, blue: 0.99),
                        Color(red: 0.8, green: 0.78, blue: 0.95)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // 2️⃣ Fullscreen background image overlay
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 16) {

                    // TOP TITLE
                    Text("Dogzy")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)
                        .shadow(radius: 4)
                        .padding(.top, 50)

                    // SUBTITLE MOVED TO TOP
                    Text("Your pet deserves the kind of care that feels like home")
                        .font(.system(size: 17, weight: .bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.horizontal, 30)
                        .padding(.top, 4)

                    Spacer()   // pushes button to bottom

                    // BUTTON — toggles the NavigationLink binding
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.black.opacity(0.85))
                            .cornerRadius(28)
                            .padding(.horizontal, 30)
                    }

                    Spacer().frame(height: 20)
                }
            }
            // Hidden NavigationLink performs the actual push
            .background(
                NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(false),
                               isActive: $navigateToLogin) {
                    EmptyView()
                }
                .hidden()
            )
            .navigationBarHidden(true)
        } // NavigationStack
    }
}

#Preview {
    // Provide a preview (inside a NavigationStack) so push works in Canvas
    WelcomeScreen()
        .previewDisplayName("WelcomeScreen -> Push LoginScreen")
}

