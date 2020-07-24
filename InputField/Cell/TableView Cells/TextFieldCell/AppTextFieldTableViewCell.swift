//
//  AppTextFieldTableViewCell.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - AppTextFieldTableViewCell
open class AppTextFieldTableViewCell: AppInputFieldTableViewCell {
    
    private var textField : AppTextField? { return (inputFieldView as? AppTextField) }
    
    public func update(placeholder : String,
                       text : String?,
                       isValidationOn : Bool,
                       isValid : Bool,
                       delegate : AppTextFieldProtocol?) {
        self.textField?.delegate = delegate
        self.textField?.text = text
        self.textField?.update(placeholder : placeholder)
        if !(text?.isEmpty ?? true) {
            textField?.updatePlaceholder(showInTop: true,isValidationOn : isValidationOn,isValid : isValid,animate: false)
        }
    }
    
    public func update(keyboardType : UIKeyboardType) {
        self.textField?.keyboardType = keyboardType
    }
    
    public func moveAsFirstResponder() {
        textField?.textField.becomeFirstResponder()
    }
    
    public func update(returnType : UIReturnKeyType) {
        textField?.textField.returnKeyType = returnType
    }
    
    public func update(isOptional : Bool) {
        textField?.update(isOptional: isOptional)
    }
}

// MARK: - AppPasswordFieldTableViewCell
open class AppPasswordFieldTableViewCell: AppTextFieldTableViewCell {
    override var type : AppInputFieldType { return .passwordField }

}

// MARK: - AppPhoneNumberTableViewCell
open class AppPhoneNumberTableViewCell: AppTextFieldTableViewCell {
    
    override var type : AppInputFieldType { return .phoneField }
    
    public func update(placeholder : String,
                       text : String,
                       isValidationOn : Bool,
                       isValid : Bool,
                       phoneDelegate : PhoneTextFieldProtocol?) {
        update(placeholder: placeholder, text: text,isValidationOn : isValidationOn,isValid : isValid,delegate: phoneDelegate)
    }
    
    public func update(countryCode : String) {
        (self.inputFieldView as? AppPhoneTextField)?.update(countryCode : countryCode)
    }
    
    override public func update(placeholder: String, text: String?,
                                isValidationOn : Bool,isValid : Bool, delegate: AppTextFieldProtocol?) {
        super.update(placeholder: placeholder, text: text,isValidationOn : isValidationOn,isValid : isValid, delegate: delegate)
    }
}

// MARK: - AppListTableViewCell
open class AppListTableViewCell: AppInputFieldTableViewCell {
    
    override var type : AppInputFieldType { return .list }
    
    private var listView : AppListInputField? { return (inputFieldView as? AppListInputField) }
    
    public func update(placeholder : String,
                       items : [String],
                       selectedPosition : Int?,
                       delegate : AppListInputProtocol?) {
        self.listView?.delegate = delegate
        self.listView?.items = items
        self.listView?.update(placeholder : placeholder)
        if let selectedPosition = selectedPosition {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self.listView?.select(at : selectedPosition)
            })
        }
    }
}


// MARK: - AppListTableViewCell
open class AppDropListTableViewCell: AppInputFieldTableViewCell {
    
    override var type : AppInputFieldType { return .arrowList }
    
    private var listView : DropListAppInputField? { return (inputFieldView as? DropListAppInputField) }
    
    public func update(placeholder : String,text : String?,delegate : AppInputFieldProtocol? = nil) {
        self.listView?.text = text
        self.listView?.inputDelegate = delegate
        self.listView?.update(placeholder : placeholder)
    }
}

