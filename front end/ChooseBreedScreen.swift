import SwiftUI

struct ChooseBreedView: View {
    struct Breed: Identifiable {
        let id = UUID()
        let name: String
        let imageName: String?
    }

    private let breeds: [Breed] = [
        Breed(name: "Labrador Retriever", imageName: "lab"),
        Breed(name: "German Shepherd", imageName: "german_shepherd"),
        Breed(name: "Golden retriver", imageName: "golden"),
        Breed(name: "rottweiler", imageName: "rottweiler"),
        Breed(name: "bulldog", imageName: "bulldog"),
        Breed(name: "Beagle", imageName: "beagle"),
        Breed(name: "Poodle", imageName: "poodle"),
        Breed(name: "siberian husky", imageName: "husky")
    ]

    @State private var selectedBreedID: UUID? = nil

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {   // ⭐ Navigation added
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                             Color(red: 0.8, green: 0.78, blue: 0.95)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 12) {

                    VStack(spacing: 6) {
                        Text("Choose Your Breed")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("let's get started by telling us what kind of dog you have")
                            .font(.system(size: 13))
                            .foregroundColor(Color.black.opacity(0.6))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 14)

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 14) {

                            ForEach(breeds) { breed in

                                // ⭐ NavigationLink added around card
                                NavigationLink(destination: BreedDetailView()) {
                                    BreedCard(
                                        breed: breed,
                                        isSelected: selectedBreedID == breed.id
                                    )
                                }
                                .buttonStyle(.plain)
                                .simultaneousGesture(
                                    TapGesture().onEnded {
                                        withAnimation(.easeInOut) {
                                            selectedBreedID = breed.id
                                        }
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                        Text("In Future more pets are to add")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.top, 14)
                            .padding(.bottom, 36)
                    }
                }
            }
        }
    }
}

// MARK: - Breed card view
fileprivate struct BreedCard: View {
    let breed: ChooseBreedView.Breed
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                // image area
                Group {
                    if let imageName = breed.imageName, UIImage(named: imageName) != nil {
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                    } else {
                        // placeholder image (rounded photo look)
                        Rectangle()
                            .fill(LinearGradient(colors: [Color.gray.opacity(0.18), Color.gray.opacity(0.08)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.system(size: 32, weight: .semibold))
                                    .foregroundColor(Color.gray.opacity(0.6))
                            )
                    }
                }
                .frame(height: 96)
                .clipped()
                .cornerRadius(10)

                // check circle
              
            }

            // breed name label
            Text(breed.name)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 6)
                .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 2)
        )
    }
}

// MARK: - Preview
#Preview {
    ChooseBreedView()
        .previewLayout(.sizeThatFits)
        
}

