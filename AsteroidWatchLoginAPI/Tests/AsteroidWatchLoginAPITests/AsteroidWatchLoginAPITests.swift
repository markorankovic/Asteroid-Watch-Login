final class AsteroidWatchLoginAPITests: Hopes {
    
    func test_login() {
        var api = AsteroidWatchLoginAPI()
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        api.signup(email: email, password: password)
        hope(api.login(email: email, password: password)) == true
    }
    
    func test_signup() {
        var api = AsteroidWatchLoginAPI()
        let email = "jackhernandez@gmail.com"
        let password = "football88"
        hope(api.signup(email: email, password: password)) == true
    }
    
}
