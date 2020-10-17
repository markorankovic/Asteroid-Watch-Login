extension AsteroidWatchLoginAPI.Client: ClientSideProtocol {
    
    public func exists(email: Email) -> Future<Bool, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                print(1)
                return promise(.success(self.server.exists(email)))
            }
        }
    }
    
    public func logout(token: Token) -> Future<LogoutResponse, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                return promise(.success(self.server.logout(token: token)))
            }
        }
    }
    
    public func getProfile(token: Token) -> Future<ProfileResponse, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                return promise(.success(self.server.getProfile(token: token)))
            }
        }
    }
    
    public func login(email: Email, password: Password) -> Future<AuthResponse, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                let token = self.server.login(email: email, password: password)
                return promise(.success(token))
            }
        }
    }
    
    public func signup(email: Email, password: Password, profile: Account.Profile) -> Future<Bool, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                let bool = self.server.signup(email: email, password: password, profile: profile)
                return promise(.success(bool))
            }
        }
    }
    
}
