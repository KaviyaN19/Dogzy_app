import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    @State private var navigateToHome = false
    @State private var navigateToSignUp = false
    @State private var navigateToForgot = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.6, green: 0.94, blue: 0.99),
                        Color(red: 0.8, green: 0.78, blue: 0.95)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 23) {
                    Spacer().frame(height: 40)

                    Text("welcome back")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.black)

                    // FORM
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Email").font(.caption)

                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)

                            TextField("Enter your mail address", text: $email)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(9)

                        Text("password").font(.caption)

                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)

                            if showPassword {
                                TextField("Enter your password", text: $password)
                            } else {
                                SecureField("Enter your password", text: $password)
                            }

                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(9)

                        HStack {
                            Spacer()
                            Button(action: {
                                navigateToForgot = true
                            }) {
                                Text("Forgot Password?")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(.horizontal, 25)

                    Spacer().frame(height: 40)

                    // LOGIN BUTTON
                    Button(action: {
                        if isValidEmail(email) && isValidPassword(password) {
                            navigateToHome = true
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.black)
                            .cornerRadius(25)
                            .padding(.horizontal, 40)
                    }

                    HStack {
                        Text("Don’t have an account?")
                            .foregroundColor(.black)

                        Button(action: {
                            navigateToSignUp = true
                        }) {
                            Text("Sign Up")
                                .foregroundColor(.blue)
                        }
                    }

                    Spacer().frame(height: 30)
                }

                // NAVIGATION
                NavigationLink(
                    destination: MainTabView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToHome
                ) { EmptyView() }
                    .hidden()

                NavigationLink(
                    destination: SignUpView(),
                    isActive: $navigateToSignUp
                ) { EmptyView() }
                    .hidden()

                NavigationLink(
                    destination: ForgotPasswordView(),
                    isActive: $navigateToForgot
                ) { EmptyView() }
                    .hidden()
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - VALIDATION LOGIC

    private func isValidEmail(_ email: String) -> Bool {
        return email.lowercased().hasSuffix("@gmail.com")
    }

    private func isValidPassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }

        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil

        return hasUppercase && hasLowercase && hasNumber
    }
}

#Preview {
    LoginScreen()
}
