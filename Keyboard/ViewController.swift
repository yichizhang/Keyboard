//
//  ViewController.swift
//  Keyboard
//
//  Created by Matt Zanchelli on 6/16/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet var textView: UITextView!
	
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
	
	required init(coder aDecoder: NSCoder!)  {
		super.init(coder: aDecoder)
		// Custom initialization
		
		registerForKeyboardNotifications()
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		resetTextViewInsets()
    }
	
	func registerForKeyboardNotifications() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
//		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
	// Called when `UIKeyboardWillShowNotification` is sent.
	func keyboardWillShow(aNotification: NSNotification) {
		
		let info = aNotification.userInfo!
		
		let sizeBegin = (info[UIKeyboardFrameBeginUserInfoKey]! as! NSValue).CGRectValue().size
		let sizeEnd = (info[UIKeyboardFrameEndUserInfoKey]! as! NSValue).CGRectValue().size
		
		let duration = (info[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber).doubleValue
		let curve = (info[UIKeyboardAnimationCurveUserInfoKey]! as! NSNumber).doubleValue
		
		
		var animationCurve: UIViewAnimationCurve
		if let value = UIViewAnimationCurve(rawValue: Int(curve)) {
			animationCurve = value
		} else {
			animationCurve = UIViewAnimationCurve.EaseInOut
		}
		
		let insets = UIEdgeInsets(top: 44, left: 0, bottom: sizeEnd.height, right: 0)
		
		UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
			self.textView.contentInset = insets
			self.textView.scrollIndicatorInsets = insets
		}, completion: nil)
	}
	
	// Called when `UIKeyboardWillHideNotification` is sent.
	func keyboardWillHide(aNotification: NSNotification) {
		let info = aNotification.userInfo!
		
		let sizeBegin = (info[UIKeyboardFrameBeginUserInfoKey]! as! NSValue).CGRectValue().size
		let sizeEnd = (info[UIKeyboardFrameEndUserInfoKey]! as! NSValue).CGRectValue().size
		
		let duration = (info[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber).doubleValue
		let curve = (info[UIKeyboardAnimationCurveUserInfoKey]! as! NSNumber).doubleValue
		
		var animationCurve: UIViewAnimationCurve
		if let value = UIViewAnimationCurve(rawValue: Int(curve)) {
			animationCurve = value
		} else {
			animationCurve = UIViewAnimationCurve.EaseInOut
		}
		
		let insets = UIEdgeInsets(top: 44, left: 0, bottom: sizeEnd.height, right: 0)
		
		UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
			self.textView.contentInset = insets
			self.textView.scrollIndicatorInsets = insets
		}, completion: nil)
	}
	
	func resetTextViewInsets() {
		let contentInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0);
		textView.contentInset = contentInsets;
		textView.scrollIndicatorInsets = contentInsets;
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	@IBAction func done(sender: AnyObject) {
		textView.resignFirstResponder()
	}
	
	@IBAction func didChangeKeyboardAppearance(sender : UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 2: // .Dark
			textView.keyboardAppearance = .Dark
		case 1: // .Light
			textView.keyboardAppearance = .Light
		case 0: // .Default
			textView.keyboardAppearance = .Default
		default:
			textView.keyboardAppearance = .Default
		}
	}
}
