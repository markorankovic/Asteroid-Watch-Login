@_exported import SwiftUI
@_exported import AsteroidWatchLoginAPI

typealias Client = AsteroidWatchLoginAPI.Client

@main
struct Asteroid_Watch_LoginApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(api: Client())
        }
    }
}
