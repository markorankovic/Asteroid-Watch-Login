struct LoginView: View {
    
    let api: Client
    
    let email: Email
    
    @State var password: Password = "" {
        didSet {
            print("Input for password: \(password)")
        }
    }
    
    @Binding var token: Token?
    
    @Binding var profile: Account.Profile?
    
    var body: some View {
        VStack {
            SecureField("Password", text: $password)
                .padding()
            Button.init(action: login, label: {
                Text("Login")
            })
            .disabled(!(email.validEmail && password.validPassword))
        }.background(
            Image("background")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    @State private var bag: Set<AnyCancellable> = []
    
    func login() {
        print("Continuing.")
        api.login(email: email, password: password).sink(
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                guard case AuthResponse.success(let token) = $0 else {
                    return
                }
                self.token = token
                goToProfile(token)
            }
        )
        .store(in: &bag)
    }
    
    func goToProfile(_ token: Token) {
        print("Continuing.")
        api.getProfile(token: token).sink(
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                print($0)
                guard case ProfileResponse.success(let p) = $0 else {
                    return
                }
                print(5)
                profile = p
            }
        )
        .store(in: &bag)
    }
    
}
