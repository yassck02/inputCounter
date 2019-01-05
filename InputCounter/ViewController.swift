//
//  ViewController.swift
//  inputCounter
//
//  Created by Connor yass on 7/16/17.
//  Copyright © 2017 Connor_yass. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var keyboardTaps: NSTextField!
	@IBOutlet weak var mouseClicks: NSTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//set the tooltips for the labels
		if let date = UserDefaults.standard.value(forKey: "startDate") as? Date {
			let formatter = DateFormatter()
			formatter.dateStyle = .medium
			let stringDate = formatter.string(from: date)
			keyboardTaps.toolTip = "Since \(stringDate)"
			mouseClicks.toolTip = "Since \(stringDate)"
		}
	}

	func updateNumbers(keyboard: Int, mouse: Int){
		keyboardTaps.stringValue = "\(keyboard)"
		mouseClicks.stringValue = "\(mouse)"
	}
	
	@IBAction func quit(_ sender: Any) {
		NSApplication.shared.terminate(self)
	}
	
}

