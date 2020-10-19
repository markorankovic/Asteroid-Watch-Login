@_exported import SwiftUI
@_exported import AsteroidWatchLoginAPI

typealias Client = AsteroidWatchLoginAPI.Client

@main
struct Asteroid_Watch_LoginApp: App {
    
    @State var api: Client = .init()
    @State var profile: Account.Profile?
    @State var launching: Bool = true
    @AppStorage("Token") private var token: Token = ""
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            if launching && !token.isEmpty {
                ProgressView()
            }
            else {
                ContentView(api: $api, profile: $profile, token: $token)
            }
        }
        .onChange(of: scenePhase) { scenePhase in
            guard case .active = scenePhase else { return }
            goToProfile(token)
        }
    }
    
    @State private var bag: Set<AnyCancellable> = []

    func goToProfile(_ token: Token) {
        DispatchQueue.main.async {
            print("Continuing.")
            api.getProfile(token: token).sink(
                receiveCompletion: { _ in
                    print("Done")
                    launching = false
                },
                receiveValue: {
                    print(token)
                    print($0)
                    guard case ProfileResponse.success(let p) = $0 else {
                        return
                    }
                    profile = p
                }
            )
            .store(in: &bag)
        }
    }
    
}
