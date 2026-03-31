import SwiftUI

struct SaveHealthRecordView: View {

    // Default sample values (used for preview + screen)
    let petName: String = "Bella"
    let diseaseName: String = "Ringworm"
    let likelihood: Double = 0.85
    let date: Date = Date()
    let veterinarian: String = "Dr. Kumar"
    let notes: String = "Mild redness observed. Monitor for 3 days."
    let attachments: [UIImage] = []   // empty for now

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

                    Text("Health Record Saved")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 20)
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

#Preview {
    SaveHealthRecordView()
}
