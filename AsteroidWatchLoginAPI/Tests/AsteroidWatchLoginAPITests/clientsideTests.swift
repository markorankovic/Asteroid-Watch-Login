final class ClientSideTests: Hopes {
    
    func test_login_success() {
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: email, password: password))")
        
        let promise = expectation(description: #function)
        
        let subscription = client.login(email: email, password: password).sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssert($0) }
        )
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }
    
    func test_login_failure() {
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        let client = AsteroidWatchLoginAPI.Client()
        print("Signup in \(#function): \(client.server.signup(email: email, password: password))")
        
        let promise = expectation(description: #function)
        
        let subscription = client.login(email: email, password: "").sink(
            receiveCompletion: { _ in promise.fulfill() },
            receiveValue: { XCTAssertFalse($0) }
        )
        
        wait(for: [promise], timeout: client.server.delay + 0.1)
    }

    
}
