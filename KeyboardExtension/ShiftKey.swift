//
//  ShiftKey.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/17/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class ShiftKey: MetaKey {
	
	// MARK: Public Properties
	
	var shiftState: KeyboardShiftState = .Disabled {
		didSet {
			// Update appearance.
			refreshAppearance()
		}
	}
	
	// MARK: Initialization
	
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
	}
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
    }

    required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
    }
	
	// MARK: Toggling state
	
	override func refreshAppearance() {
		super.refreshAppearance()
		switch shiftState {
			case .Disabled:
				imageView.tintColor = disabledTintColor
				imageView.image = UIImage(named: "Shift Disabled")
			case .Enabled:
				imageView.tintColor = enabledTintColor
				imageView.image = UIImage(named: "Shift Enabled")
			case .Locked:
				imageView.tintColor = enabledTintColor
				imageView.image = UIImage(named: "Caps Lock")
		}
	}
	
	var potentiallyDoubleTapping: Bool = false
	
	var doubleTapTimer: NSTimer!
	
	override func didSelect() {
		if potentiallyDoubleTapping == true {
			self.shiftState = .Locked
			potentiallyDoubleTapping = false
			doubleTapTimer?.invalidate()
		} else {
			switch shiftState {
				case .Disabled:
					self.shiftState = .Enabled
				case .Enabled, .Locked:
					self.shiftState = .Disabled
			}
			potentiallyDoubleTapping = true
			doubleTapTimer = NSTimer(timeInterval: 0.3, target: self, selector: "failedToDoubleTapShift:", userInfo: nil, repeats: false)
			NSRunLoop.currentRunLoop().addTimer(doubleTapTimer, forMode: NSDefaultRunLoopMode)
		}
		
		super.didSelect()
	}
	
	func failedToDoubleTapShift(timer: NSTimer) {
		potentiallyDoubleTapping = false
	}

}
