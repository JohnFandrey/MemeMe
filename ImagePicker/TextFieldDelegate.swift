//
//  TextFieldDelegate.swift
//  ImagePicker
//
//  Created by Katie Fandrey on 4/3/18.
//  Copyright © 2018 Katie Fandrey. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var topCount = 0
    var bottomCount = 0
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" && topCount == 0 {
            textField.text = ""
            topCount += 1
        }
        if textField.text == "BOTTOM" && bottomCount == 0 {
            textField.text = ""
            bottomCount += 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
