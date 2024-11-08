//
//  IslandApp.swift
//  Island
//
//  Created by Jayant Sogikar on 30/10/24.
//

import SwiftUI

@available(macOS 15.0, *)
@main
struct IslandApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(HiddenTitleBarWindowStyle())
            .windowResizability(.contentSize)
    }
}
