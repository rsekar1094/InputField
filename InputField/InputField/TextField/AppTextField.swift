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
    func didTextChange(textField : UITextField,text : String)
    func isValid(textField : UITextField,text : String) -> (Bool,String?) // (valid,errorMessage)
    func shouldEndEditing(textField : UITextField) -> Bool
    func shouldReturn(textField : UITextField) -> Bool
    
    var needToShowTickOrCross : Bool { get }
}

extension AppTextFieldProtocol {
    func shouldEndEditing(textField : UITextField) -> Bool {
        return true
    }
    
    func shouldReturn(textField : UITextField) -> Bool {
         return true
    }
    
    var needToShowTickOrCross : Bool { return true }
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
    
    public var isOptional : Bool = false
    
    
    override var isValid : Bool {
        if let delegate = self.delegate {
            return delegate.isValid(textField: self.textField, text: textField.text ?? "").0
        } else {
            return false
        }
    }
    
    // MARK: - Override methods
    override func addSubViews() {
        super.addSubViews()
        
        containerView.addArrangedSubview(textField)
        containerView.addArrangedSubview(resultImageView)
    }
    
    override func getConstraints() -> [NSLayoutConstraint] {
        var constraints = super.getConstraints()
        constraints.append(resultImageView.widthAnchor.constraint(equalToConstant: 25))
        constraints.append(resultImageView.heightAnchor.constraint(equalToConstant: 25))
        return constraints
    }
    
    override func additionalSetUp() {
        super.additionalSetUp()
        textField.delegate = self
        updatePlaceholder(show : false,animate : false)
    }
    
    @objc
    private func didTextChange(_ textField : UITextField) {
        let finalString = textField.text ?? ""
        if let delegate = self.delegate {
            delegate.didTextChange(textField: textField,text : finalString)
            let result = delegate.isValid(textField: textField, text: finalString)
            if delegate.needToShowTickOrCross {
                updateError(show: !result.0,errorMessage : result.1)
            }
        }
    }
    
    // MARK: - Configure methods
    override func setPlacehoder(_ placehoder : String) {
        super.setPlacehoder(placehoder)
        if isOptional {
            textField.placeholder = " \(placehoder) (\(NSLocalizedString("Optional", comment: "")))"
        } else {
            textField.placeholder = " \(placehoder) "
        }
    }
    
    private func updatePlaceholderView(currentText : String?) {
        updatePlaceholder(show : !(currentText?.isEmpty ?? true))
    }
    
    // MARK: - UITextFieldDelegate
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updatePlaceholder(show : true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        updatePlaceholderView(currentText : textField.text)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var finalString = ""
        if let textFieldString = textField.text {
            finalString = NSString(string: textFieldString).replacingCharacters(in: range, with: string)
        }
        hideErrorTip()
        updatePlaceholderView(currentText : finalString)
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updatePlaceholderView(currentText : textField.text)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return delegate?.shouldEndEditing(textField : textField) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.shouldReturn(textField : textField) ?? true
    }
    
}
