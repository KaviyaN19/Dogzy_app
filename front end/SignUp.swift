import SwiftUI

struct SignUpView: View {
    // MARK: - Form state
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var mobile = ""
    @State private var petName = ""
    @State private var petSpecies = ""
    @State private var petAge = ""
    @State private var petBreed = ""
    @State private var petWeight = ""
    @State private var showPassword = false

    // navigation states
    @State private var navigateToHome = false
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

                ScrollView {
                    VStack(spacing: 18) {

                        HStack { Spacer() }.frame(height: 6)

                        Circle()
                            .fill(Color.white)
                            .frame(width: 72, height: 72)
                            .overlay(
                                Image(systemName: "pawprint.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(14)
                                    .foregroundColor(Color.purple.opacity(0.6))
                            )

                        VStack(spacing: 6) {
                            Text("Create Your Account")
                                .font(.system(size: 33, weight: .bold))
                                .foregroundColor(.black)

                            Text("Join Dogzy to manage your Dog's life")
                                .font(.system(size: 15))
                                .foregroundColor(.purple.opacity(0.9))
                        }

                        VStack(spacing: 13) {
                            LabelText("Full Name")
                            RoundedInputTextField(text: $fullName, placeholder: "Enter your name")

                            LabelText("Email")
                            RoundedInputTextField(text: $email, placeholder: "Enter your email address", keyboard: .emailAddress)

                            LabelText("password")
                            PasswordField(password: $password, show: $showPassword, placeholder: "Create a Password")

                            LabelText("Mobile Number")
                            RoundedInputTextField(text: $mobile, placeholder: "Enter your Mobile No", keyboard: .phonePad)

                            Rectangle()
                                .fill(Color.white.opacity(0.6))
                                .frame(height: 1)
                                .padding(.vertical, 8)

                            HStack {
                                Text("Tell us about your Dog")
                                    .font(.system(size: 19, weight: .semibold))
                                Spacer()
                            }

                            LabelText("pet's name")
                            RoundedInputTextField(text: $petName, placeholder: "e.g., buddy")

                            LabelText("pet's age (years)")
                            RoundedInputTextField(text: $petAge, placeholder: "e.g., 2")

                            LabelText("Pet Breed")
                            RoundedInputTextField(text: $petBreed, placeholder: "Enter your pet Breed")

                            LabelText("Pet Weight")
                            RoundedInputTextField(text: $petWeight, placeholder: "Enter your pet Weight")
                        }
                        .padding(.horizontal, 20)

                        // REGISTER BUTTON (VALIDATION ADDED)
                        Button(action: {
                            if isValidEmail(email) && isValidPassword(password) {
                                navigateToHome = true
                            }
                        }) {
                            Text("Register")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color.black)
                                .cornerRadius(22)
                        }
                        .padding(.horizontal, 30)

                        Text("by registering you agree to our Terms of service and privacy policy")
                            .font(.system(size: 11))
                            .foregroundColor(.black.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)

                        HStack(spacing: 9) {
                            Text("Already have an account?")
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.8))
                            Button(action: {
                                navigateToLogin = true
                            }) {
                                Text("Log In")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.blue)
                            }
                        }

                        Spacer().frame(height: 26)
                    }
                    .frame(maxWidth: 390)
                }

                NavigationLink(
                    destination: HomeDashboardView()
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToHome
                ) { EmptyView() }
                .hidden()

                NavigationLink(
                    destination: LoginScreen(),
                    isActive: $navigateToLogin
                ) { EmptyView() }
                .hidden()
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - VALIDATION LOGIC

    private func isValidEmail(_ email: String) -> Bool {
        email.lowercased().hasSuffix("@gmail.com")
    }

    private func isValidPassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        return hasUppercase
    }
}

// MARK: - Subviews

fileprivate struct LabelText: View {
    let text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(.black.opacity(0.75))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate struct RoundedInputTextField: View {
    @Binding var text: String
    var placeholder: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboard)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .font(.system(size: 13))
            .padding(10)
            .background(Color.white)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.black.opacity(0.12), lineWidth: 1)
            )
    }
}

fileprivate struct PasswordField: View {
    @Binding var password: String
    @Binding var show: Bool
    var placeholder: String

    var body: some View {
        HStack {
            if show {
                TextField(placeholder, text: $password)
            } else {
                SecureField(placeholder, text: $password)
            }

            Button(action: { show.toggle() }) {
                Image(systemName: show ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .font(.system(size: 13))
        .padding(10)
        .background(Color.white)
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.black.opacity(0.12), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    SignUpView()
}
