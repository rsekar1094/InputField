//
//  PasswordAppTextField.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

open class AppPasswordTextField: AppTextField {
    
    internal lazy var showPasswordView : UIImageView = {
        let resultImageView = UIImageView()
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        resultImageView.contentMode = .scaleAspectFit
        resultImageView.image = UIImage.get(.eye)?.withRenderingMode(.alwaysTemplate)
        resultImageView.tintColor = self.configuration.textColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPressShowPassword))
        resultImageView.isUserInteractionEnabled = true
        resultImageView.addGestureRecognizer(tapGesture)
        return resultImageView
    }()
    
    // MARK: - Override methods
    override func addSubViews() {
        super.addSubViews()
        
        containerView.insertArrangedSubview(showPasswordView, at: 1)
    }
    
    override func getConstraints() -> [NSLayoutConstraint] {
        var constraints = super.getConstraints()
        let widthConstraint = showPasswordView.widthAnchor.constraint(equalToConstant: 20)
        widthConstraint.priority = UILayoutPriority.init(900)
        constraints.append(widthConstraint)
        
        let heightConstraint = showPasswordView.heightAnchor.constraint(equalToConstant: 20)
        heightConstraint.priority = UILayoutPriority.init(900)
        constraints.append(heightConstraint)
        return constraints
    }
    
    override func additionalSetUp() {
        super.additionalSetUp()
        
        textField.isSecureTextEntry = true
    }
    
    // MARK: - Action methods
    @objc
    private func didPressShowPassword() {
        self.textField.isSecureTextEntry = !self.textField.isSecureTextEntry
        
        if self.textField.isSecureTextEntry {
            showPasswordView.image = UIImage.get(.eye)
        } else {
            showPasswordView.image = UIImage.get(.eyeSlash)
        }
    }
    
    override public func update(textColor : UIColor) {
        super.update(textColor: textColor)
        self.showPasswordView.tintColor = textColor
    }
}
