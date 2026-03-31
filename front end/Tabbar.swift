import SwiftUI

struct MainTabView: View {
    enum Tab { case home, detect, records, tips, profile }
    @State private var selectedTab: Tab = .home

    var body: some View {
        TabView(selection: $selectedTab) {

            // Home
            NavigationStack {
                HomeDashboardView()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(Tab.home)

            // Detect (AI Disease)
            NavigationStack {
                AIDiseaseDetectionView()
            }
            .tabItem {
                Image(systemName: "wand.and.stars")
                Text("Detect")
            }
            .tag(Tab.detect)

            // Records (HealthRecords)
            NavigationStack {
                SaveHealthRecordView()
            }
            .tabItem {
                Image(systemName: "folder.fill")
                Text("Records")
            }
            .tag(Tab.records)

            // Tips / Grooming
            NavigationStack {
                GroomingTipsListView()
            }
            .tabItem {
                Image(systemName: "scissors")
                Text("Tips")
            }
            .tag(Tab.tips)

            // Profile
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Profile")
            }
            .tag(Tab.profile)
        }
        .tint(Color.purple) // app-wide tint for selected item
    }
}

#Preview {
    MainTabView()
}
