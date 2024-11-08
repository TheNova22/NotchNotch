//
//  AppDelegate.swift
//  Island
//
//  Created by Jayant Sogikar on 30/10/24.
//
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        DispatchQueue.main.async { [self] in
            guard let window = NSApplication.shared.windows.first else {
                assertionFailure("No window found")
                return
            }
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
//            window.isOpaque = false
            window.backgroundColor = .clear
//            window.hasShadow = false
//            window.ignoresMouseEvents = true // Allow mouse interaction
            window.level = .screenSaver // Keep it above other windows
            window.styleMask = [.borderless, .hudWindow]
            NSApplication.shared.activate(ignoringOtherApps: true)
            if let screen = NSScreen.screens.first {
                let screenFrame = screen.frame
                let windowWidth: CGFloat = 300
                let windowHeight: CGFloat = 60
                let xPosition = screenFrame.midX - (windowWidth  / 2)
                print(screenFrame.midX,screenFrame.maxX)
                let yPosition = screenFrame.maxY - windowHeight
                window.setFrame(NSRect(x: xPosition, y: yPosition, width: windowWidth, height: windowHeight), display: true)
                window.display()
            }
        }
    }
}
