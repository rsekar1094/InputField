//
//  AppTextField.swift
//  InputField App
//
//  Created by Rajasekar on 16/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - AppTextFieldProtocol
public protocol AppTextFieldProtocol : AppInputFieldProtocol {
    func didTextChange(inputField : AppTextField,text : String)
    func isValid(inputField : AppTextField,text : String) -> (Bool,String?) // (valid,errorMessage)
    func shouldEndEditing(inputField : AppTextField) -> Bool
    func shouldReturn(inputField : AppTextField) -> Bool
}

extension AppTextFieldProtocol {
    func shouldEndEditing(textField : UITextField) -> Bool {
        return true
    }
    
    func shouldReturn(textField : UITextField) -> Bool {
         return true
    }
}

// MARK: - AppTextField
open class AppTextField : AppInputField,UITextFieldDelegate {
    
    // MARK: - Properties
    internal lazy var textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.textColor = self.configuration.textColor
        textField.addTarget(self, action: #selector(didTextChange(_:)), for: .editingChanged)
        textField.backgroundColor = .clear
        textField.autocapitalizationType = .none
        return textField
    }()
    
    var delegate : AppTextFieldProtocol? {
        get {
            return inputDelegate as? AppTextFieldProtocol
        }
        set {
            inputDelegate = newValue
        }
    }
    
    public var text : String? {
        get {
            return textField.text
        }
        
        set {
            textField.text = newValue
        }
    }
    
    public var keyboardType : UIKeyboardType {
        get {
            return textField.keyboardType
        }
        
        set {
            textField.keyboardType = newValue
        }
    }
    
    public var returnType : UIReturnKeyType {
        get {
            return textField.returnKeyType
        }
        set {
             textField.returnKeyType = newValue
        }
    }
    
    override var isValid : Bool {
        if let delegate = self.delegate {
            return delegate.isValid(inputField : self, text: textField.text ?? "").0
        } else {
            return false
        }
    }
    
    override var isInputFocused : Bool { return textField.isFirstResponder }
    
    // MARK: - Override methods
    override func addSubViews() {
        super.addSubViews()
        
        containerView.addArrangedSubview(textField)
        containerView.addArrangedSubview(resultImageView)
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        self.textField.resignFirstResponder()
        return super.resignFirstResponder()
    }
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        self.textField.becomeFirstResponder()
        return true
    }
    
    override func getConstraints() -> [NSLayoutConstraint] {
        var constraints = super.getConstraints()
        let widthConstraint = resultImageView.widthAnchor.constraint(equalToConstant: 20)
        widthConstraint.priority = UILayoutPriority.init(900)
        constraints.append(widthConstraint)
        
        let heightConstraint = resultImageView.heightAnchor.constraint(equalToConstant: 20)
        heightConstraint.priority = UILayoutPriority.init(900)
        constraints.append(heightConstraint)
        return constraints
    }
    
    override func additionalSetUp() {
        super.additionalSetUp()
        textField.delegate = self
        updatePlaceholder(showInTop : false,isValidationOn: false,isValid : false,animate : false)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        updatePlaceholder(showInTop: false,isValidationOn: false,isValid : false,animate : false)
    }
    
    @objc
    private func didTextChange(_ textField : UITextField) {
        let finalString = textField.text ?? ""
        if let delegate = self.delegate {
            delegate.didTextChange(inputField: self,text : finalString)
            if isValidationOn {
                let result = delegate.isValid(inputField: self, text: finalString)
                updateError(errorMessage : result.1,reloadIfNeed : true)
            }
        }
    }
    
    // MARK: - Configure methods
    private func updatePlaceholderView(isValid : Bool,isValidationOn : Bool,currentText : String?) {
        updatePlaceholder(showInTop : !(currentText?.isEmpty ?? true) || isInputFocused,isValidationOn: isValidationOn,isValid : isValid)
    }
    
    // MARK: - UITextFieldDelegate
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updatePlaceholder(showInTop : true,isValidationOn: isValidationOn,isValid : self.isValid)
        updateborder(isValidationOn: isValidationOn, isValid: isValid)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updatePlaceholderView(isValid : self.isValid,isValidationOn : isValidationOn,currentText : textField.text)
        updateborder(isValidationOn: isValidationOn, isValid: isValid)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var finalString = ""
        if let textFieldString = textField.text {
            finalString = NSString(string: textFieldString).replacingCharacters(in: range, with: string)
        }
        updatePlaceholderView(isValid : self.isValid,isValidationOn : isValidationOn,currentText : finalString)
        return true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return delegate?.shouldEndEditing(textField : textField) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.shouldReturn(textField : textField) ?? true
    }
    
    override public func update(textColor : UIColor) {
        super.update(textColor: textColor)
        self.textField.textColor = textColor
    }
}
