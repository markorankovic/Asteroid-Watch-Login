extension AsteroidWatchLoginAPI.Client {
    public func login(email: AccountTypeAliases.Email, password: AccountTypeAliases.Password) -> Future<Bool, APIError> {
        Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(APIError(message: "Server deallocated")))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.server.delay) {
                let bool = self.server.login(email: email, password: password)
                return promise(.success(bool))
            }
        }
    }
}
