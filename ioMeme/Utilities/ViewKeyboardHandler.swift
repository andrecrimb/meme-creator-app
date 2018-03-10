//
//  KeyboardHandler.swift
//  ioMeme
//
//  Created by Andre Rosa on 25/01/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height + 16
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
}

