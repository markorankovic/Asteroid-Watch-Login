struct ContentView: View {
    let app: Asteroid_Watch_LoginApp
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(app: Asteroid_Watch_LoginApp())
    }
}
