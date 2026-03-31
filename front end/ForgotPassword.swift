import SwiftUI

struct ForgotPasswordView: View {
    @State private var userName: String = ""
    @State private var email: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""

    @State private var navigateToLogin = false

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

                VStack(spacing: 18) {
                    HStack {
                        Text("Forgot password")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)

                    VStack(spacing: 14) {
                        LabeledField(title: "user name") {
                            TextField("name", text: $userName)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }

                        LabeledField(title: "Email id") {
                            TextField("example@mail.com", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }

                        LabeledField(title: "New password") {
                            PasswordField(
                                placeholder: "Enter new Password",
                                text: $newPassword
                            )
                        }

                        LabeledField(title: "Confirm New password") {
                            PasswordField(
                                placeholder: "Enter Confirm Password",
                                text: $confirmPassword
                            )
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.98))
                            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                    )
                    .padding(.horizontal, 18)

                    Spacer()

                    // VALIDATE BUTTON (LOGIC ADDED)
                    Button(action: {
                        if isValidPassword(newPassword),
                           newPassword == confirmPassword {
                            navigateToLogin = true
                        }
                    }) {
                        Text("Validate")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.black)
                            )
                    }
                    .padding(.horizontal, 36)
                    .padding(.bottom, 22)

                    NavigationLink(
                        destination: LoginScreen()
                            .navigationBarBackButtonHidden(true),
                        isActive: $navigateToLogin
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - PASSWORD VALIDATION
    private func isValidPassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }
        let hasUppercase =
            password.range(of: "[A-Z]", options: .regularExpression) != nil
        return hasUppercase
    }
}

// MARK: - PasswordField (Secure with eye toggle)
fileprivate struct PasswordField: View {
    let placeholder: String
    @Binding var text: String

    @State private var isSecure: Bool = true

    var body: some View {
        HStack(spacing: 8) {
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.vertical, 10)
            .padding(.leading, 4)

            Button(action: { isSecure.toggle() }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 4)
        }
    }
}

fileprivate struct LabeledField<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.gray)

            HStack(spacing: 8) {
                content
                    .padding(.vertical, 10)
                    .padding(.horizontal, 8)
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                    )
            )
        }
    }
}

// MARK: - Preview
#Preview {
    ForgotPasswordView()
}
