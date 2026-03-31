import SwiftUI

struct ProfileView: View {
    // USER
    @State private var firstName: String = ""
    @State private var email: String = ""
    @State private var mobile: String = ""

    // PET
    @State private var petName: String = ""
    @State private var petAge: String = ""
    @State private var petWeight: String = ""
    @State private var petBreed: String = ""

    @State private var savedAlert = false

    // Warning states
    @State private var showDeleteAlert = false
    @State private var showLogoutAlert = false

    // Navigation
    @State private var navigateToLogin = false

    // Profile photo
    @State private var showProfilePhotoPicker = false

    var body: some View {
        NavigationStack {
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

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {

                        // HEADER
                        HStack {
                            Text("Profile")
                                .font(.system(size: 30, weight: .bold))

                            Spacer()

                            Button {
                                showProfilePhotoPicker = true
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 90, height: 80)
                                        .shadow(color: .black.opacity(0.1), radius: 5)

                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .font(.system(size: 26))
                                }
                            }
                        }
                        .padding(.horizontal, 22)
                        .padding(.top, 35)

                        // USER
                        Group {
                            fieldLabel("First Name")
                            boxField(text: $firstName, placeholder: "Enter first name")

                            fieldLabel("Email")
                            boxField(text: $email, placeholder: "example@email.com", keyboard: .emailAddress)

                            fieldLabel("Mobile Number")
                            boxField(text: $mobile, placeholder: "+91 9XXXXXXXXX", keyboard: .phonePad)
                        }
                        .padding(.horizontal, 22)

                        // PET
                        Group {
                            fieldLabel("Pet Name")
                            boxField(text: $petName, placeholder: "Buddy")

                            fieldLabel("Pet Age")
                            boxField(text: $petAge, placeholder: "3", keyboard: .numberPad)

                            fieldLabel("Pet Weight")
                            boxField(text: $petWeight, placeholder: "12 kg")

                            fieldLabel("Pet Breed")
                            boxField(text: $petBreed, placeholder: "Golden Retriever")
                        }
                        .padding(.horizontal, 22)

                        // SAVE
                        Button {
                            savedAlert = true
                        } label: {
                            primaryButton("Save", bg: .black)
                        }
                        .alert("Saved", isPresented: $savedAlert) {
                            Button("OK", role: .cancel) {}
                        }

                        // LOGOUT (WARNING)
                        Button {
                            showLogoutAlert = true
                        } label: {
                            primaryButton("Log out", bg: .white, text: .red)
                        }

                        // DELETE ACCOUNT (WARNING)
                        Button {
                            showDeleteAlert = true
                        } label: {
                            primaryButton("Delete Account", bg: .red)
                        }

                        Spacer().frame(height: 40)
                    }
                }

                // 🔔 LOGOUT WARNING
                if showLogoutAlert {
                    warningPopup(
                        icon: "arrow.backward.circle.fill",
                        iconColor: .red,
                        title: "Log out?",
                        message: "You will be logged out from your account.",
                        confirmText: "Log out",
                        confirmColor: .red
                    ) {
                        showLogoutAlert = false
                        navigateToLogin = true
                    } cancelAction: {
                        showLogoutAlert = false
                    }
                }

                // ⚠️ DELETE WARNING
                if showDeleteAlert {
                    warningPopup(
                        icon: "exclamationmark.triangle.fill",
                        iconColor: .red,
                        title: "Delete Account?",
                        message: "This action is permanent. All your data will be deleted and cannot be recovered.",
                        confirmText: "Delete",
                        confirmColor: .red
                    ) {
                        showDeleteAlert = false
                        navigateToLogin = true
                    } cancelAction: {
                        showDeleteAlert = false
                    }
                }

                // NAVIGATION
                NavigationLink(
                    destination: LoginScreen()
                        .navigationBarBackButtonHidden(true),
                    isActive: $navigateToLogin
                ) { EmptyView() }
                .hidden()
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Reusable Warning Popup
    @ViewBuilder
    private func warningPopup(
        icon: String,
        iconColor: Color,
        title: String,
        message: String,
        confirmText: String,
        confirmColor: Color,
        confirmAction: @escaping () -> Void,
        cancelAction: @escaping () -> Void
    ) -> some View {
        Color.black.opacity(0.35)
            .ignoresSafeArea()

        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 44))
                .foregroundColor(iconColor)

            Text(title)
                .font(.title3)
                .fontWeight(.bold)

            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            HStack(spacing: 12) {
                Button("Cancel", action: cancelAction)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(12)

                Button(confirmText, action: confirmAction)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(confirmColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 40)
    }

    // MARK: - Helpers
    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func boxField(
        text: Binding<String>,
        placeholder: String,
        keyboard: UIKeyboardType = .default
    ) -> some View {
        TextField(placeholder, text: text)
            .keyboardType(keyboard)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .shadow(color: .black.opacity(0.08), radius: 4)
    }

    private func primaryButton(
        _ title: String,
        bg: Color,
        text: Color = .white
    ) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(text)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(bg)
            .cornerRadius(16)
            .padding(.horizontal, 40)
    }
}

// MARK: - Preview
#Preview {
    ProfileView()
}
