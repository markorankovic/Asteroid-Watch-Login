struct ProfileView: View {
    
    let api: Client
    @Binding var profile: Account.Profile?
    @Binding var token: Token?
    
    var body: some View {
        if let profile = profile {
            VStack {
                LogoView()
                    .padding(.bottom, 100)
                Text("Name: \(profile.name)")
                    .padding()
                Text("Gender: \(profile.gender.rawValue)")
                    .padding()
                Button.init(action: { logout() }, label: {
                    Text("Log Out")
                })
            }.background(
                Image("background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
            )
        } else {
            EmptyView()
        }
    }
    
    @State private var bag: Set<AnyCancellable> = []

    func logout() {
        guard let token = token else { return }
        api.logout(token: token).sink(receiveCompletion: { _ in
            print("Completed.")
        }, receiveValue: {
            print("Value received.")
            if case LogoutResponse.success = $0 {
                print("Returning to Welcome screen.")
                returnToWelcome()
            }
        })
        .store(in: &bag)
    }
    
    func returnToWelcome() {
        profile = nil
    }
    
}
