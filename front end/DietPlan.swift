import SwiftUI

struct DietPlanView: View {
    // Breed picker
    @State private var selectedBreed: String = "Golden Retriever"
    private let breeds = ["Golden Retriever", "Labrador", "Beagle", "Poodle", "Bulldog"]

    // Bottom tab selection
    enum Tab { case home, detect, record, tips, profile }
    @State private var selectedTab: Tab = .detect   // detect highlighted like screenshot

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                         Color(red: 0.8, green: 0.78, blue: 0.95)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 15) {
                // MARK: - Header
                VStack(alignment: .leading, spacing: 9) {
                    Text("Diet Plan")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.black)

                    Text("Select a Breed")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 18)
                .padding(.top,50)

                // MARK: - Breed selector
                HStack {
                    Menu {
                        ForEach(breeds, id: \.self) { breed in
                            Button(action: { selectedBreed = breed }) {
                                Text(breed)
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedBreed)
                                .font(.system(size: 15))
                                .foregroundColor(.black)

                            Spacer()

                            // little green chevron like dropdown arrow
                            Image(systemName: "chevron.down")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.green)
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                        )
                        .shadow(color: Color.black.opacity(0.03),
                                radius: 4, x: 0, y: 2)
                    }
                    .frame(height: 48)
                    .padding(.horizontal, 18)
                }

                // MARK: - Scrollable content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {

                        // Daily Portion Guide card
                        InfoCard {
                            HStack(alignment: .firstTextBaseline, spacing: 6) {
                                Text("scale")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.green)
                                Text("Daily Portion Guide")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                Spacer()
                            }

                            Text("Based on a healthy, adult \(selectedBreed). Adjust portions based on activity level and consult your vet.")
                                .font(.system(size: 14))
                                .foregroundColor(.black.opacity(0.9))
                                .padding(.top, 6)

                            VStack(alignment: .leading, spacing: 8) {
                                BulletRow(text: "Puppy (3–6 mo): 2–3 cups/day")
                                BulletRow(text: "Young Adult (6–12 mo): 3–4 cups/day")
                                BulletRow(text: "Adult (1–7 yrs): 2.5–3.5 cups/day")
                            }
                            .padding(.top, 9)
                        }

                        // Recommended Foods card
                        InfoCard {
                            HStack(alignment: .firstTextBaseline, spacing: 6) {
                                Text("restaurant")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.teal)
                                Text("Recommended Foods")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                Spacer()
                            }

                            Text("High-quality commercial kibble is a great foundation for their diet. Look for foods rich in:")
                                .font(.system(size: 14))
                                .foregroundColor(.black.opacity(0.9))
                                .padding(.top, 6)

                            VStack(alignment: .leading, spacing: 8) {
                                BulletRow(text: "Lean Proteins: chicken, fish, lamb")
                                BulletRow(text: "Healthy Fats: Omega-3 and Omega-6")
                                BulletRow(text: "Complex Carbs: brown rice, sweet potatoes")
                            }
                            .padding(.top, 9)
                        }

                        // Foods to Avoid card
                        InfoCard {
                            HStack(alignment: .firstTextBaseline, spacing: 6) {
                                Text("block")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.red)
                                Text("Foods to Avoid")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                Spacer()
                            }

                            Text("Certain human foods can be toxic to dogs. Never feed your \(selectedBreed):")
                                .font(.system(size: 14))
                                .foregroundColor(.black.opacity(0.9))
                                .padding(.top, 6)

                            VStack(alignment: .leading, spacing: 8) {
                                BulletRow(text: "Chocolate & grapes")
                                BulletRow(text: "Onions & garlic")
                                BulletRow(text: "Avocado & macadamia nuts")
                            }
                            .padding(.top, 9)
                        }

                        // tiny disclaimer at very bottom
                        Text("Always consult with your veterinarian before making any changes to your dog’s diet. This information is a general guide and may not be suitable for all dogs.")
                            .font(.system(size: 11))
                            .foregroundColor(.black.opacity(0.55))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 8)
                            .padding(.horizontal, 6)
                            .padding(.bottom, 28)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 6)
                    .frame(maxHeight: .infinity, alignment: .top)
                }

                // MARK: - Bottom Tab Bar
              
            }
        }
    }
}

// MARK: - Reusable card + bullet rows

fileprivate struct InfoCard<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.04),
                radius: 6, x: 0, y: 4)
    }
}

fileprivate struct BulletRow: View {
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 5, height: 5)
                .padding(.top, 5)
            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.black.opacity(0.9))
            Spacer()
        }
    }
}

// MARK: - Tab bar button

fileprivate struct TabButton: View {
    let tab: DietPlanView.Tab
    @Binding var selected: DietPlanView.Tab
    let label: String
    let systemImage: String

    var body: some View {
        Button {
            selected = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(selected == tab ? .purple : .gray.opacity(0.7))
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(selected == tab ? .purple : .gray.opacity(0.7))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {
    DietPlanView()
        .previewLayout(.sizeThatFits)
        .frame(width: 390, height: 844)
}

