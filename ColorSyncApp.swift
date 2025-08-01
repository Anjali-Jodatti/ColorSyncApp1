import SwiftUI
import FirebaseCore

@main
struct ColorSyncApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
