public enum AuthResponse {
    case error(String)
    case success(Token)
}

public class Account {
    
    var email: Email
    let profile: Profile
    
    public init(email: String, profile: Profile) {
        self.email = email
        self.profile = profile
    }
    
    public class Profile {
        
        var name: String
        var age: Int
        
        public init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
    }
    
}

public struct AsteroidWatchLoginAPI {
    
    public init() {}
    
    public class Server {
        public let delay = 3.0
        internal var emailPasswordAccountPairs: [Email : (Password, Account)] = [:]
        internal var loggedInAccounts: Set<Email> = []
        public init() {}
    }
    
    public class Client {
        public var server = Server()
        public init() {}
    }

}
