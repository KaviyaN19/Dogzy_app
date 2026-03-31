import SwiftUI

/// BreedDetailView.swift
/// Detailed breed page (Golden Retriever) matching the screenshot:
/// - top nav (back + menu)
/// - large rounded image card
/// - General Info table (Origin, Lifespan, Size, Temperament)
/// - Vaccination Schedule card with "View Full Schedule" button
/// - Diet Plan card
/// - Grooming Tips card
/// - Primary CTA "Select This Breed"
/// - Bottom tab bar (Home / Detect / Records / Tips / Profile)
///
/// Replace image asset names (e.g. "golden") with your real assets as needed.

struct BreedDetailView: View {
    // local tab selection enum for bottom bar
    enum Tab { case home, detect, records, tips, profile }
    @State private var selectedTab: Tab = .records

    // demo breed info
    private let breedName = "Golden Retriever"
    private let origin = "Scotland"
    private let lifespan = "10-12 years"
    private let size = "Large"
    private let temperament = "Friendly, Intelligent, Devoted"

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                         Color(red: 0.8, green: 0.78, blue: 0.95)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 12) {
               
                HStack {
                    Text(breedName)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 18)
                .padding(.top,40)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)

                    // Replace "golden" with your asset name
                    Group {
                        if UIImage(named: "golden") != nil {
                            Image("golden")
                                .resizable()
                                .scaledToFill()
                        } else {
                            // placeholder
                            Rectangle()
                                .fill(LinearGradient(colors: [Color.gray.opacity(0.2), Color.gray.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay(Image(systemName: "photo").font(.system(size: 40)).foregroundColor(.gray.opacity(0.5)))
                        }
                    }
                    .frame(height: 220)
                    .clipped()
                    .cornerRadius(14)
                    .padding(12)
                }
                .padding(.horizontal, 18)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        // General Info card
                        CardView {
                            Text("General Info")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.bottom, 6)

                            VStack(spacing: 10) {
                                InfoRow(title: "Origin", value: origin)
                                Divider()
                                InfoRow(title: "Lifespan", value: lifespan)
                                Divider()
                                InfoRow(title: "Size", value: size)
                                Divider()
                                InfoRow(title: "Temperament", value: temperament)
                            }
                        }

                        // Vaccination Schedule card
                        CardView {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Vaccination Schedule")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }

                                Text("Key vaccines include Distemper, Parvovirus, and Rabies. Consult a vet for a personalized schedule.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black.opacity(0.75))

                                .padding(.top, 4)
                            }
                        }

                        // Diet Plan card
                        CardView {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Diet Plan")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }

                                Text("Requires high-quality dog food rich in protein. Typical adult portion: 2 to 2.5 cups of food per day, divided into 2 meals.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black.opacity(0.75))
                            }
                        }

                        // Grooming Tips card
                        CardView {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Grooming Tips")
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.black)
                                    Spacer()
                                }

                                Text("Their thick coat requires regular grooming to prevent matting and reduce shedding. Brush at least twice a week; bathe occasionally.")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black.opacity(0.75))
                            }
                        }

                        Spacer().frame(height: 80) // leave room for CTA & tab bar
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 6)
                } // ScrollView
            } // VStack
        } // ZStack
    }
}

// MARK: - Small reusable components

fileprivate struct CardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 4)
    }
}

fileprivate struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.gray)
                .frame(width: 92, alignment: .leading)

            Text(value)
                .font(.system(size: 13))
                .foregroundColor(.black)
            Spacer()
        }
    }
}

fileprivate struct BottomTabButton: View {
    let tab: BreedDetailView.Tab
    @Binding var selected: BreedDetailView.Tab
    let label: String
    let systemImage: String

    var body: some View {
        Button(action: { selected = tab }) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(selected == tab ? Color.purple : Color.gray.opacity(0.6))
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(selected == tab ? Color.purple : Color.gray.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {
    BreedDetailView()
        .previewLayout(.sizeThatFits)
        .frame(width: 390, height: 844)
}

