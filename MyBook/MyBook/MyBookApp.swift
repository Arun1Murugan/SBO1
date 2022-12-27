//
//  MyBookApp.swift
//  MyBook
//
//  Created by Arun Skyraan  on 21/12/22.
//

import SwiftUI

@main
struct MyBookApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
