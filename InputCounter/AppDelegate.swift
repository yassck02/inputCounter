
//
//  AppDelegate.swift
//  inputCounter
//
//  Created by Connor yass on 7/16/17.
//  Copyright © 2017 Connor_yass. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {

	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
	let popover = NSPopover()
	let popoverWindow = NSWindow()
	var clickEventMonitor: GlobalEventMonitor?
	var keyboardEventMonitor: GlobalEventMonitor?

	var clickCount = 0;
	var keyboardCount = 0;
	
	// gets called before the application is done launching
	func applicationWillFinishLaunching(_ notification: Notification) {
		clickCount = UserDefaults.standard.integer(forKey: "clickCount_total")
		keyboardCount = UserDefaults.standard.integer(forKey: "keyboardCount_total")
		
		if UserDefaults.standard.bool(forKey: "x") == false {
			let date = Date()
			UserDefaults.standard.set(date, forKey: "startDate")
			UserDefaults.standard.set(true, forKey: "x")
		}
	}

	
	// gets called when the application is done launchingVallier1
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
		//create the menubar icon/button
		if let button = statusItem.button {
			
			let icon = NSImage(named: NSImage.Name(rawValue: "MenuBarIcon"))
			statusItem.image = icon
			button.action = #selector(AppDelegate.togglePopover)
		}
		
		statusItem.length = CGFloat(30)
		
		// create a popover with a view controler from the main storyboard
		let storyBoard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
		popover.contentViewController = storyBoard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "Input Counter")) as? ViewController
	
		
		//create the event monitor to look for mouse clicks
		clickEventMonitor = GlobalEventMonitor(mask: [NSEvent.EventTypeMask.leftMouseDown, NSEvent.EventTypeMask.rightMouseDown, NSEvent.EventTypeMask.otherMouseDown]) {
			(event: NSEvent?) in
				self.processEvent(event!)
		}
		
		//create the event monitor to look for keyboard clicks
		keyboardEventMonitor = GlobalEventMonitor(mask: NSEvent.EventTypeMask.keyDown) {
			(event: NSEvent?) in
				self.processEvent(event!)
		}
		
		print("AXIsProcessTrusted: \(AXIsProcessTrusted())")
		popover.delegate = self
	}
	
	// processes an event and updates counts accordingly
	func processEvent(_ event: NSEvent){
		switch(event.type) {
		case NSEvent.EventType.keyDown:
			keyboardCount += 1
			break
		case NSEvent.EventType.rightMouseUp:
			self.clickCount += 1
			break
		case NSEvent.EventType.leftMouseDown:
			self.clickCount += 1
			break
		default:
			break
		}
		if(popover.isShown){
			let x = popover.contentViewController as! ViewController
			x.updateNumbers(keyboard: keyboardCount, mouse: clickCount)
		}
	}
	
	
	// this function shows the poppver achored at the menu bar button
	func showPopover(sender: AnyObject?) {
		if let button = statusItem.button {
			
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
			
			let x = popover.contentViewController as! ViewController
			x.updateNumbers(keyboard: keyboardCount, mouse: clickCount)
		}
	}

	
	// closes the poppver
	func closePopover(sender: AnyObject?) {
		popover.performClose(self)
	}
	
	
	// closes if open, opens if closed
	@objc func togglePopover(sender: AnyObject?) {
		if popover.isShown {
			closePopover(sender: self)
		} else {
			showPopover(sender: self)
		}
	}
	
	
	// makes it so that the popover can be detatched as a window
	func popoverShouldDetach(_ popover: NSPopover) -> Bool {
		return true
	}

	
	// gets called before the app quits
	func applicationWillTerminate(_ aNotification: Notification) {
		// save numbers to user defaults
		UserDefaults.standard.set(clickCount, forKey: "clickCount_total")
		UserDefaults.standard.set(keyboardCount, forKey: "keyboardCount_total")
	}
	

}

