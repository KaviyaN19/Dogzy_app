//
//  GroomingTip.swift
//  Dogzy
//
//  Created by SAIL on 11/12/25.
//

import SwiftUI

// MARK: - Model
struct GroomingTip: Identifiable {
    let id = UUID()
    let title: String
    let short: String
    let icon: String
    let detail: String
    let steps: [String]
    let recommended: [String]
}

// MARK: - List Screen (source)
struct GroomingTipsListView: View {
    private let tips: [GroomingTip] = [
        GroomingTip(
            title: "Coat Care",
            short: "Brushing, bathing, and de-shedding.",
            icon: "tshirt.fill",
            detail: "Proper coat care keeps your dog's skin healthy and reduces shedding around the house. Use the right brush for your dog's coat type and bathe only when necessary to avoid stripping natural oils.",
            steps: [
                "Choose a brush suitable for the coat (slicker, bristle, undercoat rake).",
                "Brush in the direction of hair growth, start gentle near skin.",
                "Remove loose hair and mats with care — use detangler if needed.",
                "Bathe with a gentle dog shampoo only as required and condition if dry."
            ],
            recommended: ["Slicker brush", "Undercoat rake", "Dog-friendly shampoo"]
        ),
        GroomingTip(
            title: "Nail Trimming",
            short: "Keeping your dog's nails healthy.",
            icon: "scissors",
            detail: "Trim nails regularly to avoid overgrowth which can cause pain or altered gait. If you hear nails clicking on hard floors, it's time for a trim.",
            steps: [
                "Use a proper dog nail trimmer or grinder.",
                "Find the quick (avoid cutting into it) — trim small amounts.",
                "If bleeding occurs, apply styptic powder and remain calm."
            ],
            recommended: ["Guillotine trimmer", "Nail grinder", "Styptic powder"]
        ),
        GroomingTip(
            title: "Ear Cleaning",
            short: "Preventing infections and buildup.",
            icon: "ear",
            detail: "Check ears weekly for redness, wax, or smell. Clean gently with a vet-approved ear cleaner and cotton pads; never insert Q-tips deep into the canal.",
            steps: [
                "Inspect ear for redness, discharge, or odor.",
                "Apply ear cleaner to a cotton pad and wipe the outer ear.",
                "If signs of infection exist, consult your veterinarian."
            ],
            recommended: ["Vet ear cleaner", "Cotton pads"]
        ),
        GroomingTip(
            title: "Dental Hygiene",
            short: "Tips for healthy teeth and gums.",
            icon: "mouth",
            detail: "Daily brushing and dental chews reduce plaque and bad breath. Start slowly so your dog gets comfortable with the process.",
            steps: [
                "Introduce the toothbrush and paste gradually.",
                "Brush 2–3 times per week at minimum.",
                "Offer dental chews and regular vet dental checks."
            ],
            recommended: ["Dog toothbrush", "Dog toothpaste", "Dental chews"]
        ),
        GroomingTip(
            title: "Paw Care",
            short: "Protecting and moisturizing paw pads.",
            icon: "pawprint.fill",
            detail: "Check paws after walks for cuts, foreign objects, or irritation. Moisturize cracked pads with pet-safe balms and trim hair between pads if needed.",
            steps: [
                "Inspect paws after outdoor walks.",
                "Remove debris and trim hair between pads.",
                "Apply paw balm for dry or cracked pads."
            ],
            recommended: ["Paw balm", "Small grooming scissors"]
        )
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                             Color(red: 0.9, green: 0.86, blue: 0.98)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 14) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Grooming Tips")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.black)
                            Text("Helpful care routines for your dog")
                                .font(.system(size: 13))
                                .foregroundColor(.black.opacity(0.65))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)

                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(tips) { tip in
                                NavigationLink(destination: GroomingDetailView(tip: tip)) {
                                    GroomingRow(tip: tip)
                                        .padding(.horizontal, 18)
                                }
                            }
                            Spacer(minLength: 30)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct GroomingRow: View {
    let tip: GroomingTip

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 52, height: 52)
                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                Image(systemName: tip.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.purple)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(tip.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(tip.short)
                    .font(.system(size: 13))
                    .foregroundColor(.black.opacity(0.7))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Detail Screen (destination)
// Removed bookmark and removed Set Reminder button as requested
struct GroomingDetailView: View {
    let tip: GroomingTip
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                         Color(red: 0.9, green: 0.86, blue: 0.98)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    // header bar (only back button retained)
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

                    // title area
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .frame(width: 68, height: 68)
                                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
                            Image(systemName: tip.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.purple)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(tip.title)
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.black)
                            Text(tip.short)
                                .font(.subheadline)
                                .foregroundColor(.purple)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)

                    // detail card
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
                            HStack {
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

                        // NOTE: 'Set Grooming Reminder' button removed as requested

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

// MARK: - Previews

struct GroomingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroomingDetailView(tip: GroomingTip(
            title: "Coat Care",
            short: "Brushing, bathing, and de-shedding.",
            icon: "tshirt.fill",
            detail: "Proper coat care keeps your dog's skin healthy and reduces shedding around the house.",
            steps: ["Brush gently", "Bathe occasionally"],
            recommended: ["Slicker brush"]
        ))
    }
}
