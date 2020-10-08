final class ServerSideTests: Hopes {
    
    func test_login() {
        let server = AsteroidWatchLoginAPI.Server()
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        print("Signup in \(#function): \(server.signup(email: email, password: password))")
        hope(server.login(email: email, password: password)) == true
    }
    
    func test_signup() {
        let server = AsteroidWatchLoginAPI.Server()
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        hope(server.signup(email: email, password: password)) == true
    }
    
}
