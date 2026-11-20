import SwiftUI

enum AppTab: String {
    case catalog
    case notes
    case targets
}

struct RootView: View {
    @StateObject private var store = CatalogStore()
    @State private var tab: AppTab = RootView.initialTab()

    var body: some View {
        TabView(selection: $tab) {
            CatalogHomeView()
                .tabItem {
                    Label { Text("tab.catalog") } icon: { Image(systemName: "sparkles") }
                }
                .tag(AppTab.catalog)

            FieldNotesView()
                .tabItem {
                    Label { Text("tab.notes") } icon: { Image(systemName: "note.text") }
                }
                .tag(AppTab.notes)

            ObservingTargetsView()
                .tabItem {
                    Label { Text("tab.targets") } icon: { Image(systemName: "scope") }
                }
                .tag(AppTab.targets)
        }
        .environmentObject(store)
        .tint(CatalogTokens.accent)
    }

    private static func initialTab() -> AppTab {
        if let raw = UserDefaults.standard.string(forKey: "launchTab"),
           let tab = AppTab(rawValue: raw) {
            return tab
        }
        let args = ProcessInfo.processInfo.arguments
        if let index = args.firstIndex(of: "-tab"), args.index(after: index) < args.count {
            return AppTab(rawValue: args[args.index(after: index)]) ?? .catalog
        }
        return .catalog
    }
}
