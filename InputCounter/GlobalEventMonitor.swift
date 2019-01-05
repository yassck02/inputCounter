//
//  GlobalEventMonitor.swift
//  inputCounter
//
//  Created by Connor yass on 7/17/17.
//  Copyright © 2017 Connor_yass. All rights reserved.
//

import Foundation
import Cocoa

class GlobalEventMonitor {
	
	var globalMonitor: Any?
	var localMonitor: Any?
	let mask: NSEvent.EventTypeMask
	let handler: (NSEvent?) -> ()
		
	init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()) {
		print("Event monitor created with mask: \(mask)")
		self.mask = mask
		self.handler = handler
		start()
	}
	
	deinit {
		stop()
	}
	
	func start() {
		print("Starting global event monitor. Mask: \(mask)")
		globalMonitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
		//print("Starting local event monitor. Mask: \(mask)")
		//localMonitor = NSEvent.addLocalMonitorForEvents(matching: mask, handler: handler)
	}
	
	func stop() {
		if (globalMonitor != nil) {
			print("Removing global event monitor with mask: \(mask)")
			NSEvent.removeMonitor(globalMonitor!)
			globalMonitor = nil
		}
		if (localMonitor != nil) {
			print("Removing local event monitor with mask: \(mask)")
			NSEvent.removeMonitor(localMonitor!)
			localMonitor = nil
		}
	}
}
