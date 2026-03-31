import SwiftUI

struct AIDiseaseDetectionView: View {
    // demo state
    @State private var selectedTab: Tab = .detect

    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    // NEW → Navigation trigger to AnalyzingView
    @State private var navigateToAnalyzing = false

    enum Tab { case home, detect, record, tips, profile }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                             Color(red: 0.8, green: 0.78, blue: 0.95)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 12) {

                    HStack { }
                        .padding(.horizontal, 16)
                        .padding(.top, 25)

                    VStack(spacing: 4) {
                        Text("AI Skin Disease Detection")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Upload a photo & get instant results")
                            .font(.system(size: 13))
                            .foregroundColor(.black.opacity(0.7))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)

                    ScrollView {
                        VStack(spacing: 18) {

                            VStack(spacing: 14) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: "")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(14)
                                            .foregroundColor(Color.purple)
                                    )

                                Text("Tap to select an image")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)

                                Text("upload a photo of the affected area")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black.opacity(0.7))

                                Button(action: {
                                    navigateToAnalyzing = true   // ← DIRECTLY GO TO ANALYZING VIEW
                                }) {
                                    Text("Upload Image")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 12)
                                        .padding(.horizontal, 36)
                                        .background(
                                            Capsule()
                                                .fill(Color.purple)
                                        )
                                }
                                .padding(.top, 6)

                            }
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
                            .padding(.horizontal, 18)
                            .padding(.top, 28)

                            VStack(alignment: .leading, spacing: 10) {
                                Text("For Best Results")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)

                                VStack(alignment: .leading, spacing: 6) {
                                    TipRow(text: "Use bright, natural light")
                                    TipRow(text: "Ensure the image is clear and in focus")
                                    TipRow(text: "Take a close-up shot of the skin")
                                    TipRow(text: "Part the fur if necessary")
                                }
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.75))

                            }
                            .padding(18)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(18)
                            .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
                            .padding(.horizontal, 18)
                            .padding(.top, 60)

                            Text("disclaimer: this tool is for informational purposes only and is not a substitute for professional veterinary advice")
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.6))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 22)
                                .padding(.bottom,20)

                        }
                    }
                }
            }

            // NEW — Hidden NavigationLink to AnalyzingView
            NavigationLink(
                destination: AnalyzingView().navigationBarBackButtonHidden(true),
                isActive: $navigateToAnalyzing
            ) { EmptyView() }
                .hidden()
        }
    }
}

// MARK: - Tip row component
fileprivate struct TipRow: View {
    let text: String
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(Color.black.opacity(0.8))
                .frame(width: 6, height: 6)
                .padding(.top, 6)
            Text(text)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    AIDiseaseDetectionView()
}
