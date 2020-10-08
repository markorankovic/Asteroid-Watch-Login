final class ServerSideTests: Hopes {
    
    func test_login() {
        var server = AsteroidWatchLoginAPI.Server()
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        server.signup(email: email, password: password)
        hope(server.login(email: email, password: password)) == true
    }
    
    func test_signup() {
        var server = AsteroidWatchLoginAPI.Server()
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        hope(server.signup(email: email, password: password)) == true
    }
    
}
