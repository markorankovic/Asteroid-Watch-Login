struct WelcomeView: View {
    
    @Binding var api: Client
    
    @State private var selection: String? = nil
    
    @State var email: Email = "" {
        didSet {
            print("Input for email: \(email)")
        }
    }
    
    @Binding var profile: Account.Profile?
    
    @State var isRequesting: Bool = false
    
    @Binding var token: Token
    
    var body: some View {
        NavigationView {
            VStack {
                LogoView()
                    .padding(.bottom, 200)
                TextField("Enter your email", text: $email)
                    .padding()
                HStack {
                    NavigationLink(
                        destination: LoginView(api: $api, email: email, token: $token, profile: $profile),
                        tag: "LoginView",
                        selection: $selection
                    ) { EmptyView() }
                    NavigationLink(
                        destination: SignupView(token: $token, api: $api, email: email, profile: $profile),
                        tag: "SignupView",
                        selection: $selection
                    ) { EmptyView() }
                    Button.init(action: next, label: {
                        Text("Next")
                    })
                }
                .disabled(!email.validEmail)
                .padding()
                Spacer()
            }.background(
                Image("background")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
    
    @State private var bag: Set<AnyCancellable> = []

    func next() {
        print("Continuing.")
        api.exists(email: email).sink(
            receiveCompletion: { _ in
                print("Done")
            },
            receiveValue: {
                selection = $0 ? "LoginView" : "SignupView"
                print(selection!)
            }
        )
        .store(in: &bag)
    }
        
}
