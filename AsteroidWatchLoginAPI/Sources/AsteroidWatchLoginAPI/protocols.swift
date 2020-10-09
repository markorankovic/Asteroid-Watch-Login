public typealias Email = String
public typealias Password = String
public typealias Token = String

protocol ClientSideProtocol {
            
    func login(email: Email, password: Password) -> Future<AuthResponse, APIError>
    
    func signup(email: Email, password: Password, profile: Account.Profile) -> Future<Bool, APIError>
        
}

protocol ServerSideProtocol {
            
    mutating func login(email: Email, password: Password) -> AuthResponse
    
    mutating func signup(email: Email, password: Password, profile: Account.Profile) -> Bool
    
    func exists(_ email: Email) -> Bool
    
    func emailAndPasswordMatch(email: Email, password: Password) -> Bool
    
}
