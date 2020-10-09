public typealias Email = String
public typealias Password = String

protocol ClientSideProtocol {
            
    func login(email: Email, password: Password) -> Future<Bool, APIError>
    
    func signup(email: Email, password: Password, profile: Account.Profile) -> Future<Bool, APIError>
        
}

protocol ServerSideProtocol {
            
    mutating func login(email: Email, password: Password) -> Bool
    
    mutating func signup(email: Email, password: Password, profile: Account.Profile) -> Bool
    
    func exists(_ email: Email) -> Bool
    
    func emailAndPasswordMatch(email: Email, password: Password) -> Bool
    
}
