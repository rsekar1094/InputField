//
//  AppInputField+Configuration.swift
//  InputField
//
//  Created by Rajasekar on 25/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit

extension AppInputField {
    public func update(placeholder : String) {
        if configuration.isOptional {
            placeholderLabel.text = placeholder
        } else {
            placeholderLabel.text = "\(placeholder)*"
        }
        configuration.placeholder = placeholder
    }
    
    public func update(focusedColor : UIColor) {
        self.configuration.focusedColor = focusedColor
    }
    
    public func update(unfocusedColor : UIColor) {
        self.configuration.unfocusedColor = unfocusedColor
    }
    
    @objc
    public func update(textColor : UIColor) {
        self.configuration.textColor = textColor
    }
    
    public func update(parentViewColor : UIColor) {
        self.configuration.parentViewColor = parentViewColor
        self.parentViewColor = parentViewColor
    }
    
    public func update(errorColor : UIColor) {
        self.configuration.errorColor = parentViewColor
    }
    
    public func update(validColor : UIColor) {
        self.configuration.validColor = validColor
    }
    
    public func update(errorShowType : ErrorShowType) {
        self.configuration.errorShowType = errorShowType
        updateErrorState()
    }
    
    public func update(placehoderColor : UIColor) {
        self.configuration.placehoderColor = placehoderColor
    }
    
    public func update(isOptional : Bool) {
        self.configuration.isOptional = isOptional
        update(placeholder: configuration.placeholder)
    }
}
