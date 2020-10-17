struct SignupView: View {
    
    @Binding var token: Token?
    
    let api: Client
    
    let email: Email
    
    @State var password: Password = "" {
        didSet {
            print("Input for password: \(password)")
        }
    }
    
    @State var gender: Gender = .other
    
    @State var name: String = ""
    
    @State var age: String = ""
    
    @State private var selection: String? = nil
    
    @Binding var profile: Account.Profile?
    
    var body: some View {
        VStack {
            LogoView()
                .padding(.bottom, 100)
            TextField("Name", text: $name)
                .padding()
            SecureField("Password", text: $password)
                .padding()
            TextField("Age", text: $age)
                .padding()
            Picker("Gender", selection: $gender) {
                Text("Female").tag(Gender.female)
                Text("Male").tag(Gender.male)
                Text("Other").tag(Gender.other)
            }
            Button.init(action: signup, label: {
                Text("Signup")
            })
            .disabled(!(password.validPassword))
        }.background(
            Image("background")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    @State private var bag: Set<AnyCancellable> = []
    
    func signup() {
        print("Continuing.")
        guard let age = Int(age) else { return }
        let p = Account.Profile(name: name, age: age, gender: gender)
        api.signup(email: email, password: password, profile: p).sink(
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                if $0 {
                    login(email: email, password: password)
                }
            }
        )
        .store(in: &bag)
    }
    
    func login(email: Email, password: Password) {
        api.login(email: email, password: password).sink (
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                if case .success(let token) = $0 {
                    self.token = token
                    getProfile(token: token)
                }
            }
        )
        .store(in: &bag)
    }
    
    func getProfile(token: Token) {
        api.getProfile(token: token).sink(
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                if case .success(let p) = $0 {
                    profile = p
                }
            }
        )
        .store(in: &bag)
    }
    
}

