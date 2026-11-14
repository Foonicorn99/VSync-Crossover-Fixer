//
//  ContentView.swift
//  FloatyWindow
//
//  Created by Lev Akmal on 11/13/26.
//

import Cocoa
import SwiftUI

class TinyFloatingPanel<Content: View>: NSPanel {
    private var initialLocation: NSPoint?

    init(contentRect: NSRect = NSRect(x: 200, y: 200, width: 10, height: 10),
         contentView: @escaping () -> Content) {
        
        super.init(
            contentRect: contentRect,
            styleMask: [.nonactivatingPanel, .borderless, .utilityWindow],
            backing: .buffered,
            defer: false
        )
        
        self.minSize = NSSize(width: 10, height: 10)
        self.maxSize = NSSize(width: 10, height: 10)
        
        self.level = .popUpMenu
        self.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary,
            .stationary,
            .ignoresCycle
        ]
        
        self.hidesOnDeactivate = false
        self.isOpaque = false
        self.backgroundColor = .clear
        self.hasShadow = false
        self.isMovableByWindowBackground = false
        
        let hostingView = NSHostingView(rootView: contentView())
        hostingView.frame = NSRect(origin: .zero, size: contentRect.size)
        self.contentView = hostingView
    }
    
    override func accessibilityRole() -> NSAccessibility.Role? {
        return .menu
    }
    
    
    override func mouseDown(with event: NSEvent) {
        self.initialLocation = event.locationInWindow
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let initialLocation = self.initialLocation else { return }
        
        let currentLocation = NSEvent.mouseLocation
        let newOrigin = NSPoint(
            x: currentLocation.x - initialLocation.x,
            y: currentLocation.y - initialLocation.y
        )
        self.setFrameOrigin(newOrigin)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.initialLocation = nil
    }
}


struct TinyDotView: View {
    var body: some View {
        
        TimelineView(.animation) { context in
            let frameTick = Int(context.date.timeIntervalSinceReferenceDate * 60) % 2
            
            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 8, height: 8)
                    .offset(x: frameTick == 0 ? 0 : 1, y: 0)
            }
            .frame(width: 10, height: 10)
            .contentShape(Rectangle())
        }
    }
}
