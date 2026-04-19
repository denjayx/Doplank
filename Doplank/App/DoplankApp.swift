//
//  DoplankApp.swift
//  Doplank
//
//  Created by Deni Wijaya on 10/04/26.
//

import SwiftUI

@main
struct DoplankApp: App {
    @UIApplicationDelegateAdaptor(AppOrientationDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
