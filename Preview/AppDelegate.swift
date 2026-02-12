//
//  AppDelegate.swift
//  Preview
//
//  Created by Sam Soffes on 8/6/15.
//  Copyright (c) 2015 Sam Soffes. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    lazy var screenSaverView = AgeView(frame: NSZeroRect, isPreview: false)

    lazy var sheetController: ConfigureSheetController = ConfigureSheetController()
    
    var preferencesWindow: NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        screenSaverView.frame = (window.contentView?.bounds)!
        window.contentView?.addSubview(screenSaverView)

        let objects = objectsFromNib(loadNibNamed: "Configuration")

        // We need to find the correct window in our nib
        let object = objects.first { object in
            if let window = object as? NSWindow, window.identifier?.rawValue == "Motivation" {
                return true
            }
            return false
        }

        if let window = object as? NSWindow {
            preferencesWindow = window
            setUp(preferencesWindow: window)
        }

    }
    
    @IBAction func showPreferences(_ sender: Any?) {
        guard let preferencesWindow = preferencesWindow else { return }
        preferencesWindow.makeKeyAndOrderFront(sender)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    private func objectsFromNib(loadNibNamed nibName: String) -> [AnyObject] {
        var topLevelObjects: NSArray? = NSArray()
        let success =  Bundle.main.loadNibNamed(
            nibName, owner: sheetController,
            topLevelObjects: &topLevelObjects
        )
        if !success {
            print("Failed to load nib \(nibName)")
        }
        return topLevelObjects! as [AnyObject]
    }

    private func setUp(preferencesWindow window: NSWindow) {
        window.makeKeyAndOrderFront(self)
        window.styleMask = [.closable, .titled, .miniaturizable]

        var frame = window.frame
        frame.origin = window.frame.origin
        window.setFrame(frame, display: true)
    }
}

