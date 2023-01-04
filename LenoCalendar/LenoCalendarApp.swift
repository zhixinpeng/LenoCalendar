//
//  LenoCalendarApp.swift
//  LenoCalendar
//
//  Created by 彭智鑫 on 2023/1/4.
//

import SwiftUI

@main
struct LenoCalendarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popOver = NSPopover()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let menuView = ContentView()
        
        popOver.behavior = .transient
        popOver.animates = true
        
        popOver.contentViewController = NSViewController()
        popOver.contentViewController?.view = NSHostingView(rootView: menuView)
    
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let menuButton = statusItem?.button {
            menuButton.image = NSImage(named: "calendar")
            menuButton.imagePosition = NSControl.ImagePosition.imageOnly
            menuButton.action = #selector(menuButtonToggle)
        }
    }
    
    @objc func menuButtonToggle(sender: AnyObject) {
        if popOver.isShown {
            popOver.performClose(sender)
        } else {
            if let menuButton = statusItem?.button {
                popOver.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: NSRectEdge.maxY)
                popOver.contentViewController?.view.window?.makeKey()
            }
        }
    }
}
