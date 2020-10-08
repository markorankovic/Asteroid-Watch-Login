protocol ClientSideProtocol: AccountTypeAliases {
            
    func login(email: Email, password: Password) -> Future<Bool, APIError>
    
    func signup(email: Email, password: Password) -> Future<Bool, APIError>
        
}

protocol ServerSideProtocol: AccountTypeAliases {
            
    mutating func login(email: Email, password: Password) -> Bool
    
    mutating func signup(email: Email, password: Password) -> Bool
    
    func exists(_ email: Email) -> Bool
    
    func emailAndPasswordMatch(email: Email, password: Password) -> Bool
    
}
