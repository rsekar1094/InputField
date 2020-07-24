//
//  AppInputField+Borders.swift
//  InputField
//
//  Created by Rajasekar on 25/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit
extension AppInputField {
    
    @objc
    internal func updateborder(isValidationOn : Bool,isValid : Bool) {
        if isValidationOn {
            if isValid {
                self.resultImageView.tintColor = configuration.validColor
                borderView.layer.borderColor = borderColor.cgColor
            } else {
                self.resultImageView.tintColor = configuration.errorColor
                borderView.layer.borderColor = configuration.errorColor.cgColor
            }
        } else {
            borderView.layer.borderColor = borderColor.cgColor
        }
        
        if self.isInputFocused {
            borderView.layer.borderWidth = 1.5
        } else {
            borderView.layer.borderWidth = 0.5
        }
        
        updatePlaceholderColor(isValidationOn: isValidationOn, isValid: isValid)
    }
    
}
