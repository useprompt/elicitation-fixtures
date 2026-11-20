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
                    Label { Text("tab_catalog") } icon: { Image(systemName: "sparkles") }
                }
                .tag(AppTab.catalog)

            FieldNotesView()
                .tabItem {
                    Label { Text("tab_notes") } icon: { Image(systemName: "note.text") }
                }
                .tag(AppTab.notes)

            ObservingTargetsView()
                .tabItem {
                    Label { Text("tab_targets") } icon: { Image(systemName: "scope") }
                }
                .tag(AppTab.targets)
        }
        .environmentObject(store)
        .tint(CatalogTokens.accent)
        .preferredColorScheme(.dark)
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
