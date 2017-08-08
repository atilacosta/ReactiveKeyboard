//
//  ReactiveKeyboard.swift
//  SplitViewChallenge
//
//  Created by Atila Costa on 08/08/17.
//  Copyright © 2017 Atila Costa. All rights reserved.
//

/** 
 
 TO USE WITH UIVIEW CONTROLLER
 
 How to use:
 
    1. Call startWatching() at viewDidLoad() or whenever
    2. Call stopWatching() at deinit() or whenever after you called startWatching()
    3. Declare keyboardConstraint variable and link it to your UITextField bottom layout constraint
 
 */

import UIKit

protocol ReactiveKeyboard {
    
    var keyboardConstraint: NSLayoutConstraint {get}
    
    func startWatching()
    func stopWatching()
    func keyboardLayoutNeeded(notification: Notification) -> Void

}
extension ReactiveKeyboard where Self: UIViewController{
    
    func startWatching(){
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: OperationQueue.main, using: { [unowned self] notification in
            self.keyboardLayoutNeeded(notification: notification)
        })
    }
    
    func stopWatching(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardLayoutNeeded(notification: Notification) {
        
        let keyboardHeightLayoutConstraint = keyboardConstraint
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                keyboardHeightLayoutConstraint.constant = 20.0
            } else {
                keyboardHeightLayoutConstraint.constant = endFrame?.size.height ?? 0.0
                keyboardHeightLayoutConstraint.constant += 10.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }

}


