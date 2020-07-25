//
//  AppTextField.swift
//  InputField App
//
//  Created by Rajasekar on 16/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - AppInputFieldProtocol
public protocol AppInputFieldProtocol : class {
    var showPossibleErrorForAll : Bool { get }
    var inputFieldController : UIViewController { get }
    
    func reloadNeed(for inputField : AppInputField)
    func canShowValidationResult(inputField : AppInputField) -> Bool
}

// MARK: - AppInputField
open class AppInputField : UIView {
    
    // MARK: - Properties
    internal lazy var verticalContainerView : UIStackView = {
        let containerView = UIStackView()
        containerView.axis = .vertical
        containerView.spacing = 5
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.distribution = .fill
        containerView.alignment = .fill
        return containerView
    }()
    
    internal lazy var borderView : UIView = {
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.layer.cornerRadius = 5
        borderView.layer.borderWidth = 1
        borderView.layer.masksToBounds = true
        borderView.layer.borderColor = borderColor.cgColor
        return borderView
    }()
    
    internal lazy var containerView : UIStackView = {
        let containerView = UIStackView()
        containerView.axis = .horizontal
        containerView.spacing = 2
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.distribution = .fill
        containerView.alignment = .fill
        return containerView
    }()
    
    internal lazy var placeholderLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = configuration.placeholderFont
        label.isUserInteractionEnabled = false
        label.textColor = self.configuration.placehoderColor
        return label
    }()
    
    internal lazy var bottomErrorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = self.configuration.errorColor
        label.numberOfLines = 0
        return label
    }()
    
    internal var errorText : String?
    
    internal lazy var resultImageView : UIImageView = {
        let resultImageView = UIImageView()
        resultImageView.translatesAutoresizingMaskIntoConstraints = false
        resultImageView.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPressStatusView))
        resultImageView.isUserInteractionEnabled = true
        resultImageView.addGestureRecognizer(tapGesture)
        resultImageView.isHidden = true
        return resultImageView
    }()
    
    internal lazy var hideBorderView : UIView = {
        let hideBorderView = UIView()
        hideBorderView.translatesAutoresizingMaskIntoConstraints = false
        hideBorderView.alpha = 0
        hideBorderView.isUserInteractionEnabled = false
        hideBorderView.backgroundColor = self.configuration.parentViewColor
        return hideBorderView
    }()
    
    internal weak var inputDelegate : AppInputFieldProtocol?
    
    internal var fieldHeight : CGFloat { return 47 }
    internal var stackViewLeftMargin : CGFloat { return 15 }
    internal var stackViewRightMargin : CGFloat { return 15 }
    internal var placeholderLeftMargin : CGFloat { return 15 }
    internal var borderColor : UIColor {
        if isInputFocused {
            return configuration.focusedColor
        } else {
            return configuration.unfocusedColor
        }
    }
    
    public var parentViewColor : UIColor = .white {
        didSet {
            hideBorderView.backgroundColor = parentViewColor
        }
    }
    
    internal var isValid : Bool { return false }
    internal var isInputFocused : Bool { return self.isFirstResponder }
    
    internal let configuration : InputFieldConfiguration
    internal weak var placeholderYAnchor : NSLayoutConstraint?
    internal weak var inputFeildHeightConstraint : NSLayoutConstraint?
    
    internal var isValidationOn : Bool {
        let showAllpossibleError = (self.inputDelegate?.showPossibleErrorForAll ?? false)
        let canShowValidationForCurrentField = self.inputDelegate?.canShowValidationResult(inputField: self) ??  true
        return showAllpossibleError || canShowValidationForCurrentField
    }
    
    // MARK: - Life cycle methods
    override public init(frame : CGRect) {
        self.configuration = InputFieldConfiguration()
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        self.configuration = InputFieldConfiguration()
        super.init(coder: coder)
        
        setUp()
    }
    
    public init(configuration : InputFieldConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        setUp()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateborder(isValidationOn: isValidationOn, isValid: isValid)
    }
    
    // MARK: - Setup
    private func setUp() {
        self.backgroundColor = .clear
        addSubViews()
        let placeholderYAnchor = placeholderLabel.centerYAnchor.constraint(equalTo: borderView.centerYAnchor)
        var constraints = getConstraints()
        constraints.append(placeholderYAnchor)
        NSLayoutConstraint.activate(constraints)
        self.placeholderYAnchor = placeholderYAnchor
        additionalSetUp()
        
        self.parentViewColor = configuration.parentViewColor
        NotificationCenter.default.addObserver(self, selector: #selector(didShowAllTextFieldError), name: .showAllFieldErrors, object: nil)
        updateErrorState()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    internal func additionalSetUp() {
        
    }
    
    // MARK: - Action methods
    @objc
    private func didShowAllTextFieldError() {
        updateborder(isValidationOn: isValidationOn, isValid: isValid)
    }
    
    @objc
    private func didPressStatusView() {
        guard let errorMessage = self.errorText else {
            return
        }
        
        guard let controller = self.inputDelegate?.inputFieldController else {
            return
        }
        
        TextPopOverController.present(text: errorMessage,
                                      configuration : self.configuration,
                                      sourceView: self.resultImageView, presentingController: controller, dismissCompletion: nil)
    }
    
    internal func updateErrorState() {
        switch configuration.errorShowType {
        case .inside:
            bottomErrorLabel.isHidden = true
            bottomErrorLabel.text = ""
        case .outsideDownLeft,.outsideDownRight:
            if errorText?.isEmpty ?? true {
                bottomErrorLabel.isHidden = true
                bottomErrorLabel.text = ""
            } else {
                bottomErrorLabel.isHidden = false
                bottomErrorLabel.text = errorText
            }
            if configuration.errorShowType == .outsideDownRight {
                bottomErrorLabel.textAlignment = .right
            } else {
                bottomErrorLabel.textAlignment = .left
            }
        }
    }
}
