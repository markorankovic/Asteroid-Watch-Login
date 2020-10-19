public enum Gender: String, Codable {
    case male
    case female
    case other
}

extension String {
    public var validEmail: Bool { contains("@") }
    public var validPassword: Bool { !isEmpty }
}

public enum ProfileResponse {
    case error(String)
    case success(Account.Profile)
}

public enum AuthResponse {
    case error(String)
    case success(Token)
}

public enum LogoutResponse {
    case error(String)
    case success(String)
}

public class Account: Codable {
    var email: Email
    let profile: Profile
    
    public init(email: String, profile: Profile) {
        self.email = email
        self.profile = profile
    }
    
    public class Profile: Codable {
        public var name: String
        public var age: Int
        public var gender: Gender
        
        public init(name: String, age: Int, gender: Gender) {
            self.name = name
            self.age = age
            self.gender = gender
        }
    }
    
}

public enum AsteroidWatchLoginAPI {
        
    public class Server {
        public let delay = 3.0
        var emailPasswordAccountPairs: [Email : (Password, Account)] = [:]
        var loggedInAccounts: [Token : Account] = [:]

        public init() {}
    }
    
    public class Client {
        public var server = Server()
        public init() {}
    }

}
