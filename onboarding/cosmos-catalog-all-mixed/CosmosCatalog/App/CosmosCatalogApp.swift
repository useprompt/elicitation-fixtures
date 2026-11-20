import SwiftUI

@main
struct CosmosCatalogApp: App {
    @State private var phase: AppPhase = CosmosCatalogApp.initialPhase()

    var body: some Scene {
        WindowGroup {
            Group {
                switch phase {
                case .splash:
                    SplashView {
                        withAnimation(.easeInOut(duration: 0.55)) {
                            phase = .home
                        }
                    }
                case .home:
                    RootView()
                }
            }
        }
    }

    private static func initialPhase() -> AppPhase {
        if UserDefaults.standard.string(forKey: "launchTab") != nil {
            return .home
        }
        let args = ProcessInfo.processInfo.arguments
        if let index = args.firstIndex(of: "-tab"), args.index(after: index) < args.count {
            return .home
        }
        return .splash
    }
}

private enum AppPhase {
    case splash
    case home
}
