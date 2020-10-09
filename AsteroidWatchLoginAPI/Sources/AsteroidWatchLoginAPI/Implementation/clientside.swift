extension AsteroidWatchLoginAPI.Client {
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
}

extension AsteroidWatchLoginAPI.Client {
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

//extension AsteroidWatchLoginAPI.Client {
//    private func task(closure: @escaping (_ email: AccountTypeAliases.Email, _ password: AccountTypeAliases.Password) -> Bool, email: AccountTypeAliases.Email, password: AccountTypeAliases.Password) -> Future<Bool, APIError> {
//        Future { [weak self] promise in
//            guard let self = self else {
//                return promise(.failure(APIError(message: "Server deallocated")))
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
//                let bool = closure(email, password, profile)
//                return promise(.success(bool))
//            }
//        }
//    }
//}
