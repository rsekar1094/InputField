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
                       delegate : AppTextFieldProtocol?) {
        self.textField?.delegate = delegate
        self.textField?.text = text
        self.textField?.setPlacehoder(placeholder)
        if !(text?.isEmpty ?? true) {
            textField?.updatePlaceholder(show: true, animate: false)
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
    
    public func update(needResultImageView : Bool) {
        textField?.needResultImageView = needResultImageView
    }
    
    public func update(isOptional : Bool) {
        textField?.isOptional = isOptional
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
                       phoneDelegate : PhoneTextFieldProtocol?) {
        update(placeholder: placeholder, text: text, delegate: phoneDelegate)
    }
    
    public func update(countryCode : String) {
        (self.inputFieldView as? AppPhoneTextField)?.update(countryCode : countryCode)
    }
    
    override public func update(placeholder: String, text: String?, delegate: AppTextFieldProtocol?) {
        super.update(placeholder: placeholder, text: text, delegate: delegate)
    }
}

// MARK: - AppListTableViewCell
open class AppListTableViewCell: AppInputFieldTableViewCell {
    
    override var type : AppInputFieldType { return .list }
    
    private var listView : AppListInputField? { return (inputFieldView as? AppListInputField) }
    
    public func update(placeholder : String,
                       items : [String],
                       selectedPosition : Int?,
                       delegate : ListInputProtocol?) {
        self.listView?.delegate = delegate
        self.listView?.items = items
        self.listView?.setPlacehoder(placeholder)
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
        self.listView?.setPlacehoder(placeholder)
    }
}

