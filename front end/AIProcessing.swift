import SwiftUI

struct AnalyzingView: View {
    @Environment(\.dismiss) private var dismiss     // ← add this
    @State private var progress: CGFloat = 0.0
    @State private var selectedTab: Tab = .detect
    @State private var navigateToReport: Bool = false

    enum Tab { case home, detect, record, tips, profile }

    private var reduceMotion: Bool { UIAccessibility.isReduceMotionEnabled }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {   // ← enable top-left alignment

                // Background gradient
                LinearGradient(
                    colors: [
                        Color(red: 0.6, green: 0.94, blue: 0.99),
                        Color(red: 0.8, green: 0.78, blue: 0.95)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                // ---------- BACK BUTTON ----------
                Button(action: {
                    dismiss()   // ← goes back to previous screen
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(12)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                }
                .padding(.leading, 20)
                .padding(.top, 50)
                // --------------------------------

                VStack(spacing: 18) {

                    VStack(spacing: 10) {
                        Text("AI Skin Disease Detection")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                        Text("Upload a photo & get instant results.")
                            .font(.system(size: 13))
                            .foregroundColor(.black.opacity(0.6))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 110)  // ← added space because of back button

                    Spacer()

                    // Card
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 4)
                            .frame(maxWidth: 340, minHeight: 180)

                        VStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .stroke(Color.purple.opacity(0.12), lineWidth: 14)
                                    .frame(width: 110, height: 110)

                                Circle()
                                    .trim(from: 0, to: progress)
                                    .stroke(
                                        AngularGradient(gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.7)]),
                                                        center: .center),
                                        style: StrokeStyle(lineWidth: 14, lineCap: .round)
                                    )
                                    .rotationEffect(.degrees(-90))
                                    .frame(width: 110, height: 110)
                                    .shadow(color: Color.purple.opacity(0.18), radius: 6, x: 0, y: 4)

                                Image(systemName: "pawprint.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 34)
                                    .foregroundColor(Color.purple)
                            }

                            Text("Analyzing your dog's skin...")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)

                            Text("This will only take a moment.")
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.6))
                        }
                        .padding(.vertical, 18)
                    }
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .onAppear {
                    if reduceMotion {
                        progress = 0.85
                    } else {
                        withAnimation(.easeOut(duration: 1.2)) {
                            progress = 0.85
                        }
                    }

                    // Auto navigation after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        navigateToReport = true
                    }
                }

                // Hidden navigation link
                NavigationLink(destination: DiseaseReportView(), isActive: $navigateToReport) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarHidden(true)
        }
    }
}
#Preview {
   AnalyzingView()
    
}
