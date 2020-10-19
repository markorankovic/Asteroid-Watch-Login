struct ContentView: View {
        
    @Binding var api: Client
    @Binding var profile: Account.Profile?
    @Binding var token: Token
                
    var body: some View {
        if profile != nil {
            ProfileView(api: $api, profile: $profile, token: $token)
        }
        else {
            WelcomeView(api: $api, profile: $profile, token: $token)
        }
    }
        
}
