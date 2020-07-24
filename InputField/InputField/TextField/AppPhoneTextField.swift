//
//  PhoneAppTextField.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - AppTextFieldProtocol
public protocol PhoneTextFieldProtocol : AppTextFieldProtocol {
    func didPressCountryLabel(inputField : AppPhoneTextField)
}

open class AppPhoneTextField : AppTextField {
    
    internal lazy var countryLabel : UILabel = {
        let countryLabel = UILabel()
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.backgroundColor = .clear
        countryLabel.textColor = self.configuration.textColor
        countryLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        countryLabel.text = phoneConfiguration?.defaultCountryPhoneCode
        countryLabel.textAlignment = .center
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPressCountryLabel))
        countryLabel.isUserInteractionEnabled = true
        countryLabel.addGestureRecognizer(tapGesture)
        return countryLabel
    }()
    
    internal lazy var separatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        let split = UIView()
        split.tag = 343
        split.backgroundColor = borderColor
        split.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(split)
        let splitViewWidthConstraint = split.widthAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([
            split.topAnchor.constraint(equalTo: view.topAnchor),
            split.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            split.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splitViewWidthConstraint
        ])
        self.splitViewWidthConstraint = splitViewWidthConstraint
        return view
    }()
    
    override var stackViewLeftMargin : CGFloat { return 0 }
    override var placeholderLeftMargin : CGFloat { return 50 }
    public var phoneConfiguration : PhoneFieldConfiguration? { return (configuration as? PhoneFieldConfiguration)  }
    private weak var splitViewWidthConstraint : NSLayoutConstraint?
    
    // MARK: - Override methods
    override func addSubViews() {
        super.addSubViews()
        
        containerView.insertArrangedSubview(countryLabel, at: 0)
        containerView.insertArrangedSubview(separatorView, at: 1)
        containerView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        containerView.isLayoutMarginsRelativeArrangement = true
    }
    
    override func getConstraints() -> [NSLayoutConstraint] {
        var constraints = super.getConstraints()
        constraints.append(countryLabel.widthAnchor.constraint(equalToConstant: 40))
        constraints.append(separatorView.widthAnchor.constraint(equalToConstant: 10))
        return constraints
    }
    
    override func additionalSetUp() {
        super.additionalSetUp()
        
        textField.keyboardType = .phonePad
    }
    
    override func updateborder(isValidationOn : Bool,isValid : Bool) {
        super.updateborder(isValidationOn : isValidationOn,isValid : isValid)
        
        if isValidationOn {
            if isValid {
                separatorView.viewWithTag(343)?.backgroundColor = borderColor
            } else {
                separatorView.viewWithTag(343)?.backgroundColor = configuration.errorColor
            }
        } else {
            separatorView.viewWithTag(343)?.backgroundColor = borderColor
        }
        
        if self.isInputFocused {
            splitViewWidthConstraint?.constant = 1.5
        } else {
            splitViewWidthConstraint?.constant = 0.5
        }
        separatorView.setNeedsLayout()
        separatorView.layoutIfNeeded()
    }
    // MARK: - Action methods
    @objc
    private func didPressCountryLabel() {
        (self.delegate as? PhoneTextFieldProtocol)?.didPressCountryLabel(inputField: self)
    }
    
    func update(countryCode : String?) {
        self.countryLabel.text = countryCode
    }
    
    public func update(defaultCountryPhoneCode : String) {
        phoneConfiguration?.defaultCountryPhoneCode = defaultCountryPhoneCode
        self.countryLabel.text = defaultCountryPhoneCode
    }
}
