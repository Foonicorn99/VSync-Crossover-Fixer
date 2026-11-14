//
//  FloatyWindowApp.swift
//  FloatyWindow
//
//  Created by Lev Akmal on 11/13/26.


import SwiftUI
@main
struct FloatingDotApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var panel: TinyFloatingPanel<TinyDotView>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        panel = TinyFloatingPanel(
            contentRect: NSRect(x: 200, y: 200, width: 10, height: 10),
            contentView: { TinyDotView() }
        )
        panel?.orderFrontRegardless()
    }
}
