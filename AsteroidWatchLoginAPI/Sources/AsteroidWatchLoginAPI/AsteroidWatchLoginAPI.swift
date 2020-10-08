public protocol AccountTypeAliases {
    typealias Email = String
    typealias Password = String
}

protocol Login: AccountTypeAliases {
            
    func login(email: Email, password: Password) -> Bool
    
    func exists(_ email: Email) -> Bool
    
    func emailAndPasswordMatch(email: Email, password: Password) -> Bool
    
}

protocol Signup: AccountTypeAliases {
    
    mutating func signup(email: Email, password: Password) -> Bool

}

extension AsteroidWatchLoginAPI {
    public func emailAndPasswordMatch(email: Email, password: Password) -> Bool {
        return password == emailPasswordPairs[email]
    }
}

extension AsteroidWatchLoginAPI {
    public func exists(_ email: Email) -> Bool {
        return emailPasswordPairs.keys.contains(email)
    }
}

extension AsteroidWatchLoginAPI {
    public func login(email: Email, password: Password) -> Bool {
        if exists(email) { return emailAndPasswordMatch(email: email, password: password) }
        return false
    }
}

extension AsteroidWatchLoginAPI {
    public mutating func signup(email: Email, password: Password) -> Bool {
        guard exists(email) else {
            emailPasswordPairs[email] = password
            return true
        }
        return false
    }
}

public struct AsteroidWatchLoginAPI: Login, Signup {
    private var emailPasswordPairs: [Email : Password] = [:]
    public init() {}
}
