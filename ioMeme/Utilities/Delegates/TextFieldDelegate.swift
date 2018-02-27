//
//  TextFieldDelegate.swift
//  ioMeme
//
//  Created by Andre Rosa on 26/01/2018.
//  Copyright © 2018 Andre Rosa. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate{
    weak var activeField: UITextField?

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        self.activeField = textField
        print(textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1000 && textField.text == ""{
             textField.text = "TOP"
        } else if textField.tag == 2000 && textField.text == ""{
            textField.text = "BOTTOM"
        }
        self.activeField = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        return true
    }
}
