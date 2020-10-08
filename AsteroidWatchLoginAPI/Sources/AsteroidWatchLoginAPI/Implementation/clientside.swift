extension AsteroidWatchLoginAPI.Client {
    public func login(email: AccountTypeAliases.Email, password: AccountTypeAliases.Password) -> Future<Bool, APIError> {
        return task(closure: server.login, email: email, password: password)
    }
}

extension AsteroidWatchLoginAPI.Client {
    public func signup(email: AccountTypeAliases.Email, password: AccountTypeAliases.Password) -> Future<Bool, APIError> {
        return task(closure: server.signup, email: email, password: password)
    }
}

extension AsteroidWatchLoginAPI.Client {
    private func task(closure: @escaping (_ email: AccountTypeAliases.Email, _ password: AccountTypeAliases.Password) -> Bool, email: AccountTypeAliases.Email, password: AccountTypeAliases.Password) -> Future<Bool, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                let bool = closure(email, password)
                return promise(.success(bool))
            }
        }
    }
}
