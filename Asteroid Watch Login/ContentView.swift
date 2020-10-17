struct ContentView: View {
        
    let api: Client
    
    @State var profile: Account.Profile? = nil
    @State var token: Token? = nil
            
    var body: some View {
        if profile != nil {
            ProfileView(api: api, profile: $profile, token: $token)
        } else {
            WelcomeView(api: api, profile: $profile, token: $token)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView(api: Client())
    }
}
