import SwiftUI

struct VaccinationTip: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let vaccine: String
    let dueInfo: String? // optional short note like "Every year"
    let iconSystemName: String
}

struct VaccinationTipsView: View {
    // Sample tips about common dog vaccinations / injections
    private let tips: [VaccinationTip] = [
        VaccinationTip(
            title: "Rabies",
            description: "Protects against rabies virus — required by law in many areas. Usually given as a single-dose initially, then boosters per vet schedule.",
            vaccine: "Rabies Vaccine",
            dueInfo: "Boosters: 1–3 years (per local rules)",
            iconSystemName: "syringe"
        ),
        VaccinationTip(
            title: "DHPP (Distemper, Hepatitis, Parvo, Parainfluenza)",
            description: "Core combination vaccine protecting against several serious diseases. Puppies typically receive a series; adults get periodic boosters.",
            vaccine: "DHPP",
            dueInfo: "Boosters: every 1–3 years (as advised)",
            iconSystemName: "cross.case.fill"
        ),
        VaccinationTip(
            title: "Bordetella (Kennel Cough)",
            description: "Recommended if your dog socializes in kennels, daycare, grooming, or dog parks. Available as intranasal, oral or injectable forms.",
            vaccine: "Bordetella",
            dueInfo: "Boosters: annually or as required",
            iconSystemName: "wind"
        ),
        VaccinationTip(
            title: "Leptospirosis",
            description: "Protects against bacterial infection transmitted by wildlife or contaminated water. Recommended in areas with higher risk.",
            vaccine: "Lepto Vaccine",
            dueInfo: "Boosters: annually",
            iconSystemName: "drop.fill"
        ),
        VaccinationTip(
            title: "Lyme Disease",
            description: "Consider in regions with ticks. Discuss risk with your vet. Often recommended for dogs that spend time in tick-prone areas.",
            vaccine: "Lyme Vaccine",
            dueInfo: "Boosters: annually",
            iconSystemName: "leaf.fill"
        )
    ]

    var body: some View {
        ZStack {
            // Background gradient matching your app style
            LinearGradient(
                colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                         Color(red: 0.9, green: 0.86, blue: 0.98)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Vaccination Tips")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                        Text("Essential injection guidance for dogs")
                            .font(.system(size: 13))
                            .foregroundColor(.black.opacity(0.65))
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)

                // Tips list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(tips) { tip in
                            VaccinationTipCard(tip: tip)
                                .padding(.horizontal, 18)
                        }

                        Spacer(minLength: 30)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

private struct VaccinationTipCard: View {
    let tip: VaccinationTip

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 48, height: 48)
                        .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                    Image(systemName: tip.iconSystemName)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.purple)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text(tip.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    Text(tip.vaccine)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.purple)
                }

                Spacer()
            }

            Text(tip.description)
                .font(.system(size: 13))
                .foregroundColor(.black.opacity(0.8))
                .fixedSize(horizontal: false, vertical: true)

            if let due = tip.dueInfo {
                HStack {
                    Image(systemName: "calendar")
                    Text(due)
                        .font(.system(size: 12, weight: .semibold))
                }
                .font(.system(size: 12))
                .foregroundColor(.black.opacity(0.7))
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    VaccinationTipsView()
}
