public typealias Email = String
public typealias Password = String
public typealias Token = String

protocol ClientSideProtocol {
            
    func login(email: Email, password: Password) -> Future<AuthResponse, APIError>
    
    func logout(token: Token) -> Future<LogoutResponse, APIError>
    
    func signup(email: Email, password: Password, profile: Account.Profile) -> Future<Bool, APIError>
    
    func getProfile(token: Token) -> Future<ProfileResponse, APIError>
        
}

protocol ServerSideProtocol {
            
    func getProfile(token: Token) -> ProfileResponse
    
    func login(email: Email, password: Password) -> AuthResponse
    
    func logout(token: Token) -> LogoutResponse
    
    func signup(email: Email, password: Password, profile: Account.Profile) -> Bool
    
    func exists(_ email: Email) -> Bool
    
    func emailAndPasswordMatch(email: Email, password: Password) -> Bool
    
}
