//
//  testUIApp.swift
//  testUI
//
//  Created by Marko Rankovic on 10/12/20.
//

import SwiftUI
import AsteroidWatchLoginAPI

@main
struct testUIApp: App {
    let client = AsteroidWatchLoginAPI.Client()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
