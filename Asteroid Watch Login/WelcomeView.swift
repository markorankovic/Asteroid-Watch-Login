struct WelcomeView: View {
    
    let app: Asteroid_Watch_LoginApp
    
    @State var email: String = "" {
        didSet {
            print("Input for email: \(email)")
        }
    }
        
    var body: some View {
        VStack {
            TextField("Enter your email", text: $email)
                .padding()
            Button.init(action: next, label: {
                Text("Next")
            })
            .disabled(!email.validEmail)
        }
    }
    
    func next() {
        print("Continuing.")
        let sub = app.client.exists(email: email).sink(
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                if $0 {
                    login()
                } else {
                    signup()
                }
            }
        )
        print("Subscription initialized: \(sub)")
    }
    
    func login() {
        
    }
    
    func signup() {
        
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(app: Asteroid_Watch_LoginApp())
    }
}
