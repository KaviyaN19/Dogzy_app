import SwiftUI

struct HealthRecordsView: View {
    // MARK: - Local models
    struct UpcomingItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let dateText: String
        let iconColor: Color
        let iconName: String
    }
    struct RecordItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let dateText: String
        let iconName: String
        let iconColor: Color
    }

    // MARK: - Demo data
    @State private var upcoming: [UpcomingItem] = [
        UpcomingItem(title: "Annual Check-up", subtitle: "Dr. Smith's Vet Clinic", dateText: "July 15, 2:00 PM", iconColor: Color.blue, iconName: "calendar"),
        UpcomingItem(title: "Grooming", subtitle: "Petzy Groomers", dateText: "July 22, 11:30 AM", iconColor: Color.teal, iconName: "scissors")
    ]

    @State private var medications: [RecordItem] = [
        RecordItem(title: "Heartworm...", subtitle: "1 chewable, monthly", dateText: "Next: Aug 1", iconName: "pills.fill", iconColor: .green),
        RecordItem(title: "Flea & Tick Treatment", subtitle: "1 topical dose, monthly", dateText: "Next: Aug 15", iconName: "drop.fill", iconColor: .green)
    ]

    @State private var allergies: [RecordItem] = [
        RecordItem(title: "Pollen", subtitle: "Avoid chicken and turkey", dateText: "Seasonal", iconName: "leaf.fill", iconColor: .orange),
        RecordItem(title: "Grass Pollen", subtitle: "Seasonal, mild reaction", dateText: "Seasonal", iconName: "leaf.circle.fill", iconColor: .orange)
    ]

    @State private var recentVisits: [RecordItem] = [
        RecordItem(title: "Rabies Vaccination", subtitle: "City Vet Hospital", dateText: "May 20, 2024", iconName: "syringe.fill", iconColor: .blue),
        RecordItem(title: "Minor Paw Injury", subtitle: "Dr. Smith's Vet Clinic", dateText: "Mar 12, 2024", iconName: "bandage.fill", iconColor: .gray)
    ]

    // tab selection
    enum Tab { case home, detect, records, tips, profile }
    @State private var selectedTab: Tab = .records

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
                // Header: title only (three-dot removed)
                HStack(spacing: 12) {
                    Text("Health Records")
                        .font(.system(size: 29, weight: .bold))
                        .foregroundColor(.black)

                    Spacer()
                }
                .padding(.top, 40)
                .padding(.horizontal, 12)

                ScrollView {
                    VStack(spacing: 18) {
                        // Upcoming section
                        SectionHeader(title: "Upcoming")

                        VStack(spacing: 12) {
                            ForEach(upcoming) { item in
                                RecordRow(title: item.title,
                                          subtitle: item.subtitle,
                                          dateText: item.dateText,
                                          iconName: item.iconName,
                                          iconColor: item.iconColor)
                            }
                        }
                        .padding(.horizontal, 12)

                        // Medications
                        SectionHeader(title: "Medications")

                        VStack(spacing: 12) {
                            ForEach(medications) { item in
                                SmallRecordRow(record: item)
                            }
                        }
                        .padding(.horizontal, 12)

                        // Allergies
                        SectionHeader(title: "Allergies")

                        VStack(spacing: 12) {
                            ForEach(allergies) { item in
                                SmallRecordRow(record: item)
                            }
                        }
                        .padding(.horizontal, 12)

                        // Recent Visits
                        SectionHeader(title: "Recent Visits")

                        VStack(spacing: 12) {
                            ForEach(recentVisits) { item in
                                RecordRow(title: item.title,
                                          subtitle: item.subtitle,
                                          dateText: item.dateText,
                                          iconName: item.iconName,
                                          iconColor: item.iconColor)
                            }
                        }
                        .padding(.horizontal, 12)

                        Spacer(minLength: 36)
                    }
                    .padding(.top, 6)
                }
            }
            // Floating add button removed (no right-side plus)
        }
    }
}

// MARK: - Subviews

fileprivate struct SectionHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

fileprivate struct RecordRow: View {
    let title: String
    let subtitle: String
    let dateText: String
    let iconName: String
    let iconColor: Color

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 52, height: 52)
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(iconColor)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "")
                        .foregroundColor(.gray.opacity(0.6))
                }

                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text(dateText)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 12)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white).shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2))
    }
}

fileprivate struct SmallRecordRow: View {
    let record: HealthRecordsView.RecordItem

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(record.iconColor.opacity(0.12))
                    .frame(width: 48, height: 48)
                Image(systemName: record.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(record.iconColor)
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(record.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "")
                        .foregroundColor(.gray.opacity(0.6))
                }

                Text(record.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

                Text(record.dateText)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 12)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white).shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2))
    }
}

fileprivate struct BottomTabButton: View {
    let tab: HealthRecordsView.Tab
    @Binding var selected: HealthRecordsView.Tab
    let label: String
    let systemImage: String

    var body: some View {
        Button(action: { selected = tab }) {
            VStack(spacing: 4) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(selected == tab ? Color.purple : Color.gray.opacity(0.6))
                Text(label)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(selected == tab ? Color.purple : Color.gray.opacity(0.6))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview
#Preview {
    HealthRecordsView()
        .previewLayout(.sizeThatFits)
}
