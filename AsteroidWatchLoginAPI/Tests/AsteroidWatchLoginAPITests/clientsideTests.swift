final class ClientSideTests: Hopes {
    
    // LOGIN
    
    func test_login_success() {
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        let profile = Account.Profile(name: "Jack", age: 38)
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: email, password: password, profile: profile))")
        
        let promise = expectation(description: #function)
        
        let subscription = client.login(email: email, password: password).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssert($0) }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_login_failure() {
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        let profile = Account.Profile(name: "Jack", age: 38)
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: email, password: password, profile: profile))")
        
        let promise = expectation(description: #function)
        
        let subscription = client.login(email: email, password: "").sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssertFalse($0) }
        )
        
        print("subscription of \(#function): \(subscription)")

        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    // SIGNUP
        
    func test_signup_success() {
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        let client = AsteroidWatchLoginAPI.Client()
        
        let promise = expectation(description: #function)

        let profile = Account.Profile(name: "Jack", age: 38)
        
        let subscription = client.signup(email: email, password: password, profile: profile).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssert($0) }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_signup_failure() {
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        let profile = Account.Profile(name: "Jack", age: 38)
        let client = AsteroidWatchLoginAPI.Client()
        
        let promise = expectation(description: #function)

        print("Signup in \(#function): \(client.server.signup(email: email, password: password, profile: profile))")

        let subscription = client.signup(email: email, password: password, profile: profile).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssertFalse($0) }
        )
        
        print("subscription of \(#function): \(subscription)")
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }

}
