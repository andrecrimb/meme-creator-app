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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("dksdk")
        if textField.tag == 1000 && textField.text == ""{
             textField.text = "TOP"
        } else if textField.tag == 2000 && textField.text == ""{
            textField.text = "BOTTOM"
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        return true
    }
}
