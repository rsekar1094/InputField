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
    func didPressCountryLabel(textField : UITextField)
}

open class AppPhoneTextField : AppTextField {
    
    internal lazy var countryLabel : UILabel = {
        let countryLabel = UILabel()
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.backgroundColor = .clear
        countryLabel.textColor = self.configuration.textColor
        countryLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        countryLabel.text = (self.configuration as? PhoneConfiguration)?.defaultCountryPhoneCode
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
        split.backgroundColor = borderColor
        split.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(split)
        NSLayoutConstraint.activate([
            split.topAnchor.constraint(equalTo: view.topAnchor),
            split.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            split.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            split.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        return view
    }()
    
    override var stackViewLeftMargin : CGFloat { return 0 }
    override var placeholderLeftMargin : CGFloat { return 50 }
    
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
    
    // MARK: - Action methods
    @objc
    private func didPressCountryLabel() {
        (self.delegate as? PhoneTextFieldProtocol)?.didPressCountryLabel(textField: self.textField)
    }
    
    func update(countryCode : String) {
        self.countryLabel.text = countryCode
    }
    
}
