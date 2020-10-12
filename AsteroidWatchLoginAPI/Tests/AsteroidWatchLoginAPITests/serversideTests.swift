final class ServerSideTests: Hopes {
    
    func test_logout() {
        let server = AsteroidWatchLoginAPI.Server()
        print("Signup in \(#function): \(server.signup(email: valid_email, password: password, profile: profile))")
        guard case .success(let token) = server.login(email: valid_email, password: password) else {
            return XCTFail()
        }
        let response = server.logout(token: token)
        guard case .success = response else {
            return XCTFail()
        }
    }
    
    func test_login() {
        let server = AsteroidWatchLoginAPI.Server()
        print("Signup in \(#function): \(server.signup(email: valid_email, password: password, profile: profile))")
        let response = server.login(email: valid_email, password: password)
        guard case .success = response else {
            return XCTFail()
        }
    }
    
    func test_signup() {
        let server = AsteroidWatchLoginAPI.Server()
        hope(server.signup(email: valid_email, password: password, profile: profile)) == true
    }
    
    func test_valid_email() {
        hope(valid_email.validEmail) == true
    }
    
    func test_invalid_email() {
        hope(invalid_email.validEmail) == false
    }
    
}
