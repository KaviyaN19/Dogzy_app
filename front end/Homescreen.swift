import SwiftUI

// HomeDashboardView.swift
// Tapping the AI, Diet, Vaccination, Grooming, Health Records or Choose Breed cards navigates to their respective screens.
// Bottom tab bar removed.

struct HomeDashboardView: View {
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
                    Spacer().frame(height: 8)

                    header
                        .padding(.horizontal, 18)
                        .padding(.top, 8)

                    profileRow
                        .padding(.horizontal, 18)
                        .padding(.top, 6)

                    // Feature grid
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)], spacing: 16) {

                            // NAVIGATION LINK -> AI Disease Detection
                            NavigationLink(destination: AIDiseaseDetectionView()) {
                                FeatureCardNew(icon: "sparkles", title: "AI Disease Detection", subtitle: "Scan symptoms instantly", color: Color.purple, foot: "Upload a photo")
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            // NAVIGATION LINK -> Diet Plan
                            NavigationLink(destination: DietPlanView()) {
                                FeatureCardNew(icon: "fork.knife", title: "Diet Plan", subtitle: "Customized meal plans", color: Color(red: 0.45, green: 0.20, blue: 0.90), foot: "Personalized guide")
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            // NAVIGATION LINK -> Vaccination Tracker
                            NavigationLink(destination: VaccinationTipsView()) {
                                FeatureCardNew(icon: "bandage.fill", title: "Vaccination Tracker", subtitle: "Never miss a shot", color: Color.blue, foot: "Reminders & history")
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            // NAVIGATION LINK -> Grooming Tips
                            NavigationLink(destination: GroomingTipsListView()) {
                                FeatureCardNew(icon: "scissors", title: "Grooming Tips", subtitle: "Keep coat healthy", color: Color(red: 0.9, green: 0.45, blue: 0.65), foot: "Brushing & bathing")
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            // NAVIGATION LINK -> Health Records
                            NavigationLink(destination: SaveHealthRecordView()) {
                                FeatureCardNew(icon: "folder", title: "Save Health Records", subtitle: "All records in one place", color: Color.teal, foot: "Vets & notes")
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())

                            // NAVIGATION LINK -> Choose Breed
                            NavigationLink(destination: ChooseBreedView()) {
                                FeatureCardNew(icon: "heart.circle", title: "Choose Breed", subtitle: "See all details", color: Color.pink, foot: "pet's information")
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        .padding(.bottom, 90)
                    }

                    // bottomTabBar removed
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .navigationBarHidden(true)
        } // NavigationStack
    }

    // MARK: - Header
    private var header: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.white)
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(10)
                        .foregroundColor(Color.purple)
                )
                .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)

            Text("dogzy")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.black)

            Spacer()
        }
    }

    // MARK: - Profile row
    private var profileRow: some View {
        HStack(alignment: .center, spacing: 12) {
            Image("Dogpic.png")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)

            VStack(alignment: .leading, spacing: 4) {
                Text("Buddy")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)

                Text("Golden Retriever, 3 yrs")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.6))

                Text("All good!")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.6))
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Feature Card (icon on top, centered text below)
fileprivate struct FeatureCardNew: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    let foot: String

    var body: some View {
        VStack(spacing: 12) {
            // Icon container at top, centered
            RoundedRectangle(cornerRadius: 14)
                .fill(LinearGradient(colors: [color.opacity(0.18), color.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 72, height: 72)
                .overlay(
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(color)
                )
                .shadow(color: Color.black.opacity(0.02), radius: 2, x: 0, y: 1)

            // Title centered below icon
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            // Subtitle
            Text(subtitle)
                .font(.system(size: 12))
                .foregroundColor(.black.opacity(0.65))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            // Small foot capsule centered
            Text(foot)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(color)
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.12)))

            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(minHeight: 160)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Preview
#Preview {
    HomeDashboardView()
        .previewLayout(.device)
        .previewDevice("iPhone 14 Pro")
}
