@_exported import SwiftUI
@_exported import AsteroidWatchLoginAPI

typealias Client = AsteroidWatchLoginAPI.Client

@main
struct Asteroid_Watch_LoginApp: App {
    
    let client = Client()
    
    var body: some Scene {
        WindowGroup {
            ContentView(app: self)
        }
    }
}
