final class ClientSideTests: Hopes {
    
    // LOGIN
    
    func test_login_success() {
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: valid_email, password: password, profile: profile))")
        
        let promise = expectation(description: #function)
        
        let subscription = client.login(email: valid_email, password: password).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: {
                guard case .success = $0 else {
                    return XCTFail()
                }
            }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_login_failure() {
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: valid_email, password: password, profile: profile))")
        
        let promise = expectation(description: #function)
        
        let subscription = client.login(email: valid_email, password: "").sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: {
                guard case .error = $0 else {
                    return XCTFail()
                }
            }
        )
        
        print("subscription of \(#function): \(subscription)")

        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    // SIGNUP
    
    func test_signup_success() {
        let client = AsteroidWatchLoginAPI.Client()
        
        let promise = expectation(description: #function)
        
        let subscription = client.signup(email: valid_email, password: password, profile: profile).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssert($0) }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_signup_failure() {
        let client = AsteroidWatchLoginAPI.Client()
        
        let promise = expectation(description: #function)

        print("Signup in \(#function): \(client.server.signup(email: valid_email, password: password, profile: profile))")

        let subscription = client.signup(email: valid_email, password: password, profile: profile).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssertFalse($0) }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    // PROFILE
    
    func test_get_profile_success() {
        let client = AsteroidWatchLoginAPI.Client()
        let promise = expectation(description: #function)
        print("Signup in \(#function): \(client.server.signup(email: valid_email, password: password, profile: profile))")
        
        guard case .success(let token) = client.server.login(email: valid_email, password: password) else {
            return XCTFail()
        }
        
        let subscription = client.getProfile(token: token).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: {
                guard case .success = $0 else {
                    return XCTFail()
                }
            }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_get_profile_failure() {
        let client = AsteroidWatchLoginAPI.Client()
        let promise = expectation(description: #function)
                
        let subscription = client.getProfile(token: "grebigbir").sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: {
                guard case .success = $0 else {
                    return print($0)
                }
                XCTFail()
            }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    // LOGOUT
    
    func test_logout_success() {
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: valid_email, password: password, profile: profile))")
        
        let promise = expectation(description: #function)
        
        guard case .success(let token) = client.server.login(email: valid_email, password: password) else {
            return XCTFail()
        }
        
        let subscription = client.logout(token: token).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: {
                guard case .success = $0 else {
                    return XCTFail()
                }
            }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_logout_failure() {
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: valid_email, password: password, profile: profile))")
        
        let promise = expectation(description: #function)
                
        let subscription = client.logout(token: "").sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: {
                guard case .success = $0 else {
                    return
                }
                return XCTFail()
            }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }

}
