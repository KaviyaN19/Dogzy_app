import SwiftUI

// -----------------------------
// Single-file, non-conflicting implementation
// - Uses unique type names to avoid "ambiguous type" errors
// - Includes a simple HealthRecordsView stub so "Cannot find 'HealthRecordsView' in scope" is resolved
// - Simple navigation: tap a card -> detail screen
// Paste this entire file into your project (remove/rename conflicting files)
// -----------------------------

// MARK: - Model (unique name)
struct DogzyGroomingTip: Identifiable {
    let id = UUID()
    let iconName: String
    let iconColor: Color
    let title: String
    let subtitle: String
    let detail: String
    let steps: [String]
    let recommended: [String]
}

// MARK: - Main list screen (unique name)
struct DogzyGroomingTipsView: View {
    // keep tab enum (unchanged)
    enum Tab { case home, detect, record, tips, profile }
    @State private var selectedTab: Tab = .detect

    private let items: [DogzyGroomingTip] = [
        DogzyGroomingTip(
            iconName: "tshirt.fill",
            iconColor: Color.blue.opacity(0.85),
            title: "Coat Care",
            subtitle: "Brushing, bathing, and de-shedding.",
            detail: "Proper coat care keeps your dog's skin healthy and reduces shedding. Use the right brush for your dog's coat type and bathe only when necessary to avoid stripping natural oils.",
            steps: [
                "Choose an appropriate brush for the coat type.",
                "Brush gently in the direction of hair growth.",
                "Remove mats carefully and use detangler if needed.",
                "Bathe only when necessary with dog-safe shampoo."
            ],
            recommended: ["Slicker brush", "Undercoat rake", "Dog shampoo"]
        ),
        DogzyGroomingTip(
            iconName: "scissors",
            iconColor: Color.blue.opacity(0.7),
            title: "Nail Trimming",
            subtitle: "Keeping your dog's nails healthy.",
            detail: "Trim nails regularly to avoid overgrowth. Trim small amounts and avoid the quick. Use styptic powder if bleeding occurs.",
            steps: ["Use proper trimmers", "Trim small bits", "Apply styptic powder if needed"],
            recommended: ["Guillotine trimmer", "Nail grinder"]
        ),
        DogzyGroomingTip(
            iconName: "ear.fill",
            iconColor: Color.blue.opacity(0.65),
            title: "Ear Cleaning",
            subtitle: "Preventing infections and buildup.",
            detail: "Inspect ears weekly; wipe outer ear gently with vet-approved cleaner. Consult vet if you see discharge or odor.",
            steps: ["Inspect ears", "Wipe outer ear with cleaner", "See vet if abnormal"],
            recommended: ["Vet ear cleaner", "Cotton pads"]
        )
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                             Color(red: 0.8, green: 0.78, blue: 0.95)],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Grooming Tips")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                        Text("Helpful routines for your dog's care")
                            .font(.system(size: 13))
                            .foregroundColor(.black.opacity(0.65))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 40)

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(items) { tip in
                                NavigationLink(destination: DogzyGroomingDetailView(tip: tip)) {
                                    DogzyTipRowView(tip: tip)
                                        .padding(.horizontal, 12)
                                }
                            }
                            Spacer().frame(height: 16)
                        }
                        .padding(.top, 8)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Row (unique)
fileprivate struct DogzyTipRowView: View {
    let tip: DogzyGroomingTip

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(tip.iconColor.opacity(0.12))
                    .frame(width: 54, height: 54)
                Image(systemName: tip.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(tip.iconColor)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(tip.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(tip.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.black.opacity(0.6))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Color.gray.opacity(0.6))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Detail screen (unique)
struct DogzyGroomingDetailView: View {
    let tip: DogzyGroomingTip
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                         Color(red: 0.9, green: 0.86, blue: 0.98)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 68, height: 68)
                                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                            Image(systemName: tip.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.purple)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(tip.title)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.black)
                            Text(tip.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.purple)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Overview")
                            .font(.headline)
                        Text(tip.detail)
                            .font(.body)
                            .foregroundColor(.black.opacity(0.85))

                        Divider()

                        Text("Steps")
                            .font(.headline)
                        ForEach(Array(tip.steps.enumerated()), id: \.offset) { idx, step in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(idx + 1).")
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundColor(.purple)
                                    .frame(width: 26)
                                Text(step)
                                    .font(.subheadline)
                                    .foregroundColor(.black.opacity(0.8))
                                Spacer()
                            }
                        }

                        if !tip.recommended.isEmpty {
                            Divider()
                            Text("Recommended Tools")
                                .font(.headline)
                            HStack(spacing: 8) {
                                ForEach(tip.recommended, id: \.self) { r in
                                    Text(r)
                                        .font(.caption)
                                        .padding(.vertical, 6)
                                        .padding(.horizontal, 10)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.purple.opacity(0.12)))
                                        .foregroundColor(.black)
                                }
                            }
                        }

                        Divider()

                        Text("Quick Tips")
                            .font(.headline)
                        Text("• Keep sessions short and positive.\n• Use treats and praise.\n• If unsure, consult your vet or professional groomer.")
                            .font(.subheadline)
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
                    .padding(.horizontal, 20)

                    Spacer(minLength: 30)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - HealthRecordsView stub (resolves "Cannot find 'HealthRecordsView' in scope")
struct HealthRecordsView: View {
    var body: some View {
        VStack {
            Text("Health Records")
                .font(.title2)
                .padding()
            Text("This is a placeholder HealthRecordsView.")
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Previews
struct DogzyGrooming_Previews: PreviewProvider {
    static var previews: some View {
        DogzyGroomingTipsView()
    }
}
