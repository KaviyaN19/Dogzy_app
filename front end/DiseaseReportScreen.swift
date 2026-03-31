import SwiftUI

// MARK: - DiseaseReportView (source screen)
struct DiseaseReportView: View {
    @State private var navigateToRecords: Bool = false

    // sample data
    private let likelihoodPercent: Int = 85
    private let conditionTitle = "Ringworm"
    private let symptoms = ["Red patches", "Itching", "Hair loss"]
    private let precautions = [
        "Avoid direct contact with the affected area.",
        "Consult a veterinarian for confirmation and treatment plan.",
        "Wash bedding, toys, and grooming tools thoroughly."
    ]

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // background
                LinearGradient(
                    colors: [Color(red: 0.6, green: 0.94, blue: 0.99),
                             Color(red: 0.8, green: 0.78, blue: 0.95)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("AI Skin Disease Detection")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        Text("Upload a photo & get instant results.")
                            .font(.system(size: 13))
                            .foregroundColor(.black.opacity(0.65))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 40)

                    ScrollView {
                        VStack(spacing: 18) {
                            resultCard
                                .padding(.horizontal, 18)

                            symptomsCard
                                .padding(.horizontal, 18)

                            precautionsCard
                                .padding(.horizontal, 18)

                            ctaButtons
                                .padding(.horizontal, 18)

                            Spacer().frame(height: 24)
                        }
                        .padding(.top, 6)
                    }
                }

                // Hidden NavigationLink to SaveHealthRecordView
                NavigationLink(
                    destination: SaveHealthRecordView(),
                    isActive: $navigateToRecords
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                    }
                }
            }
        }
    }

    // MARK: - Subviews
    private var resultCard: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)

            VStack(spacing: 14) {
                Text(conditionTitle)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                CircularPercentView(percent: likelihoodPercent,
                                    thickness: 14,
                                    gradient: Gradient(colors: [Color.purple.opacity(0.95), Color.purple]),
                                    backgroundColor: Color.purple.opacity(0.15))
                    .frame(width: 120, height: 120)

                Text("Disclaimer: This is an AI suggestion and not a substitute for professional veterinary advice.")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
            }
            .padding(.vertical, 16)
        }
    }

    private var symptomsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Symptoms")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            // simple chips (horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(symptoms, id: \.self) { s in
                        Text(s)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.purple)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Capsule().fill(Color.purple.opacity(0.12)))
                    }
                }
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white).shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2))
    }

    private var precautionsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Precautions")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)

            VStack(alignment: .leading, spacing: 10) {
                ForEach(Array(precautions.enumerated()), id: \.offset) { idx, p in
                    HStack(alignment: .top, spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.purple.opacity(0.12))
                                .frame(width: 36, height: 36)
                            Image(systemName: ["shield.lefthalf.fill","stethoscope","drop.fill"][idx % 3])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.purple)
                        }

                        Text(p)
                            .font(.system(size: 13))
                            .foregroundColor(.black.opacity(0.8))
                        Spacer()
                    }
                }
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white).shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2))
    }

    private var ctaButtons: some View {
        VStack(spacing: 12) {
            Button(action: {
                navigateToRecords = true
            }) {
                Text("Save to Health Records")
                    .font(.system(size: 15, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.purple))
                    .foregroundColor(Color.white)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.purple, lineWidth: 1))
            }
        }
    }
}


// MARK: - SaveHealthRecordView (destination screen)
struct SaveHealthRecord: View {
    // Default sample values (used for preview + screen)
    let petName: String = "Bella"
    let diseaseName: String = "Ringworm"
    let likelihood: Double = 0.85
    let date: Date = Date()
    let veterinarian: String = "Dr. Kumar"
    let notes: String = "Mild redness observed. Monitor for 3 days."
    let attachments: [UIImage] = []

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.6, green: 0.94, blue: 0.99),
                    Color(red: 0.8, green: 0.78, blue: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    // Header with back button
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    Text("Health Record Saved")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)

                    // Main Card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Pet:")
                                .font(.headline)
                            Spacer()
                            Text(petName)
                        }

                        HStack {
                            Text("Disease:")
                                .font(.headline)
                            Spacer()
                            Text(diseaseName)
                        }

                        HStack {
                            Text("Likelihood:")
                                .font(.headline)
                            Spacer()
                            Text("\(Int(likelihood * 100))%")
                                .foregroundColor(.purple)
                        }

                        HStack {
                            Text("Date:")
                                .font(.headline)
                            Spacer()
                            Text(dateformatted)
                        }

                        VStack(alignment: .leading) {
                            Text("Notes:")
                                .font(.headline)
                            Text(notes)
                                .padding(.top, 4)
                        }

                        if !attachments.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Attachments:")
                                    .font(.headline)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(attachments.indices, id: \.self) { i in
                                            Image(uiImage: attachments[i])
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 90, height: 90)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.08), radius: 5)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding(.bottom, 40)
            }
        }
    }

    private var dateformatted: String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}

// MARK: - CircularPercentView
fileprivate struct CircularPercentView: View {
    let percent: Int
    let thickness: CGFloat
    let gradient: Gradient
    let backgroundColor: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: thickness)
                .foregroundColor(backgroundColor)

            Circle()
                .trim(from: 0, to: CGFloat(percent)/100)
                .rotation(Angle(degrees: -90))
                .stroke(AngularGradient(gradient: gradient, center: .center), style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .shadow(color: Color.purple.opacity(0.2), radius: 6, x: 0, y: 4)
                .animation(.easeOut(duration: 0.6), value: percent)

            VStack(spacing: 2) {
                Text("\(percent)%")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(Color.purple)
                Text("Likelihood")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.6))
            }
        }
    }
}

// MARK: - Previews
struct DiseaseReportView_Previews: PreviewProvider {
    static var previews: some View {
        DiseaseReportView()
    }
}
