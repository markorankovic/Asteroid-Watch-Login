extension AsteroidWatchLoginAPI.Server {
    func accountFrom(_ token: Token) -> Account? {
        guard let account = loggedInAccounts[token] else {
            return nil
        }
        return account
    }
}

extension AsteroidWatchLoginAPI.Server: ServerSideProtocol {
    
    public func logout(token: Token) -> LogoutResponse {
        guard loggedInAccounts[token] != nil else { return .error("Invalid token.") }
        loggedInAccounts.removeValue(forKey: token)
        saveToStorage()
        return .success("You have successfully logged out.")
    }
    
    func getProfile(token: Token) -> ProfileResponse {
        loadFromStorage()
        guard let account = accountFrom(token) else {
            return .error("Invalid token")
        }
        return .success(account.profile)
    }
    
    public func login(email: Email, password: Password) -> AuthResponse {
        if emailAndPasswordMatch(email: email, password: password) {
            guard let account = emailPasswordAccountPairs[email]?.1 else { return .error("Unknown error.") }
            let token = generateUserToken()
            loggedInAccounts[token] = account
            saveToStorage()
            return .success(token)
        }
        return .error("Login failure: Invalid username or password.")
    }
    
    private func saveToStorage() {
        do {
            let emailPasswordPairs = emailPasswordAccountPairs.mapValues{ $0.0 }
            let emailAccountPairs = emailPasswordAccountPairs.mapValues{ $0.1 }
            let data1 = try JSONEncoder().encode(emailPasswordPairs)
            let data2 = try JSONEncoder().encode(emailAccountPairs)
            let data3 = try JSONEncoder().encode(loggedInAccounts)
            UserDefaults.standard.setValue(data1, forKey: "emailPasswordPairs")
            UserDefaults.standard.setValue(data2, forKey: "emailAccountPairs")
            UserDefaults.standard.setValue(data3, forKey: "loggedInAccounts")
        } catch { print("Error saving to storage: \(error)") }
        print("Saved")
    }
    
    private func loadFromStorage() {
        func arrToDict(arr: [(key: Email, value: (Password, Account))]) -> [Email: (Password, Account)] {
            var result: [Email: (Password, Account)] = [:]
            for e in arr {
                result[e.key] = e.value
            }
            return result
        }
        do {
            if let data1 = UserDefaults.standard.value(forKey: "emailPasswordPairs") as? Data,
               let data2 = UserDefaults.standard.value(forKey: "emailAccountPairs") as? Data,
               let data3 = UserDefaults.standard.value(forKey: "loggedInAccounts") as? Data {
                
                let emailPasswordPairs = try JSONDecoder().decode([Email : Password].self, from: data1)
                let emailAccountPairs = try JSONDecoder().decode([Email : Account].self, from: data2)
                loggedInAccounts = try JSONDecoder().decode([Token : Account].self, from: data3)
                let finalPair = emailPasswordPairs.compactMap{ Dictionary.Element(key: $0.key, value: ($0.value, emailAccountPairs[$0.key]!)) }
                self.emailPasswordAccountPairs = arrToDict(arr: finalPair)
                print("Loaded: \(emailPasswordPairs)")
            }
        } catch { print("Error loading from storage: \(error)") }
    }
    
    public func signup(email: Email, password: Password, profile: Account.Profile) -> Bool {
        guard exists(email) && email.validEmail else {
            let account = Account(email: email, profile: profile)
            emailPasswordAccountPairs[email] = (password, account)
            saveToStorage()
            return true
        }
        return false
    }
    
    public func emailAndPasswordMatch(email: Email, password: Password) -> Bool {
        if let pair = emailPasswordAccountPairs[email] {
            return password == pair.0
        }
        return false
    }

    public func exists(_ email: Email) -> Bool {
        return emailPasswordAccountPairs.keys.contains(email)
    }
    
}

extension AsteroidWatchLoginAPI.Server {
    func generateUserToken() -> Token {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return (1...10).map{ _ in "(\(randomNumberGenerator.next()))" }.joined()
    }
}
