//
//  AppInputField+Placeholder.swift
//  InputField
//
//  Created by Rajasekar on 25/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit
extension AppInputField {
    
    @objc
    internal func updatePlaceholderColor(isValidationOn : Bool,isValid : Bool) {
        if isValidationOn {
            if isValid {
                self.placeholderLabel.textColor = isInputFocused ? borderColor : configuration.placehoderColor
            } else {
                self.placeholderLabel.textColor = configuration.errorColor
            }
        } else {
            placeholderLabel.textColor = isInputFocused ? borderColor : configuration.placehoderColor
        }
    }
    
    @objc
    internal func updatePlaceholder(showInTop : Bool,isValidationOn : Bool,isValid : Bool,animate : Bool = true) {
        var constant : CGFloat
        
        if showInTop {
            constant = -20
        } else {
            constant = 0
        }
        
        if constant != self.placeholderYAnchor?.constant ?? 0 {
            if showInTop {
                hideBorderView.alpha = 1
            } else {
                hideBorderView.alpha = 0
            }
            
            func setColorAndReload() {
                updatePlaceholderColor(isValidationOn: isValidationOn, isValid: isValid)
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
            
            self.placeholderYAnchor?.constant = constant
            
            self.placeholderLabel.animate(font: showInTop ? self.configuration.focusedPlaceholderFont : self.configuration.placeholderFont, duration: 0.1)
            
            if animate {
                UIView.animate(withDuration: 0.1, animations: {
                    setColorAndReload()
                })
            } else {
                setColorAndReload()
            }
        }
    }
}
