//
//  AppTextField.swift
//  InputField App
//
//  Created by Rajasekar on 16/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import AMPopTip

// MARK: - AppInputFieldProtocol
public protocol AppInputFieldProtocol : class {
    var showPossibleErrorForAll : Bool { get }
}

extension AppInputFieldProtocol {
    var showPossibleErrorForAll : Bool { return false }
}

// MARK: - AppInputField
open class AppInputField : UIView {
    
    // MARK: - Properties
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
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.distribution = .fill
        containerView.alignment = .fill
        return containerView
    }()
    
    internal lazy var placeholderLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.layer.cornerRadius = 5
        label.textColor = borderColor
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
    
    private lazy var hideBorderView : UIView = {
        let hideBorderView = UIView()
        hideBorderView.translatesAutoresizingMaskIntoConstraints = false
        hideBorderView.backgroundColor = self.configuration.parentViewColor
        return hideBorderView
    }()
    
    private weak var popTip : PopTip?
    
    internal weak var inputDelegate : AppInputFieldProtocol?
    
    public var needResultImageView : Bool = true {
        didSet {
            if !needResultImageView {
                resultImageView.isHidden = true
            }
        }
    }
    internal var stackViewLeftMargin : CGFloat { return 15 }
    internal var stackViewRightMargin : CGFloat { return 15 }
    internal var placeholderLeftMargin : CGFloat { return 10 }
    internal var borderColor : UIColor {
        return configuration.defaultBorderColor
    }
    
    public var parentViewColor : UIColor = .white {
        didSet {
            hideBorderView.backgroundColor = parentViewColor
        }
    }
    
    internal var isValid : Bool { return false }
    
    internal let configuration : Configuration

    // MARK: - Life cycle methods
    override public init(frame : CGRect) {
        self.configuration = Configuration()
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        self.configuration = Configuration()
        super.init(coder: coder)
        
        setUp()
    }
    
    public init(configuration : Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        setUp()
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if resultImageView.image != nil {
            if isValid {
                borderView.layer.borderColor = borderColor.cgColor
            } else {
                borderView.layer.borderColor = UIColor.red.cgColor
            }
        } else {
            borderView.layer.borderColor = borderColor.cgColor
        }
    }
    
    // MARK: - Setup
    private func setUp() {
        self.backgroundColor = .clear
        addSubViews()
        NSLayoutConstraint.activate(getConstraints())
        additionalSetUp()
        
        self.parentViewColor = configuration.parentViewColor
        NotificationCenter.default.addObserver(self, selector: #selector(didShowAllTextFieldError), name: .showAllFieldErrors, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    internal func additionalSetUp() {
        
    }
    
    internal func setPlacehoder(_ placehoder : String) {
        placeholderLabel.text = " \(placehoder) "
    }
    
    @objc
    public func didShowAllTextFieldError() {
        if let delegate = self.inputDelegate,delegate.showPossibleErrorForAll {
            if isValid {
                borderView.layer.borderColor = configuration.tintColor.cgColor
            } else {
                borderView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    // MARK: - Action methods
    @objc
    private func didPressStatusView() {
        if let _ = popTip {
            hideErrorTip()
            return
        }
        
        guard let errorMessage = self.errorText else {
            return
        }
        
        let popTip = PopTip()
        let rect = CGRect(origin: CGPoint(x: resultImageView.frame.center.x, y: borderView.frame.center.y - (borderView.frame.height / 2)), size: resultImageView.frame.size)
        popTip.show(text: errorMessage, direction: .autoHorizontal, maxWidth: borderView.frame.width - 100, in: self, from:  rect)
        self.popTip = popTip
    }
    
    // MARK: - View Methods
    internal func addSubViews() {
        self.addSubview(borderView)
        borderView.addSubview(containerView)
        self.addSubview(hideBorderView)
        self.addSubview(placeholderLabel)
    }
    
    internal func getConstraints() -> [NSLayoutConstraint] {
        var constraints : [NSLayoutConstraint] = []
        
        //borderView
        constraints.append(borderView.heightAnchor.constraint(equalToConstant: 42))
        constraints.append(borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10))
        constraints.append(borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10))
        constraints.append(borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5))
        
        //containerView
        constraints.append(containerView.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(containerView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor,constant: stackViewLeftMargin))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor,constant: -stackViewRightMargin))
        
        //placeholderLabel
        constraints.append(placeholderLabel.bottomAnchor.constraint(equalTo: borderView.topAnchor,constant: 5))
        constraints.append(placeholderLabel.leftAnchor.constraint(equalTo: borderView.leftAnchor,constant: placeholderLeftMargin))
        constraints.append(placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 5))
    
        //hideBorderView
        constraints.append(hideBorderView.topAnchor.constraint(equalTo: borderView.topAnchor))
        constraints.append(hideBorderView.leadingAnchor.constraint(equalTo: placeholderLabel.leadingAnchor))
        constraints.append(hideBorderView.trailingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor))
        constraints.append(hideBorderView.heightAnchor.constraint(equalToConstant: 1))
        
        return constraints
    }

    internal func updatePlaceholder(show : Bool,animate : Bool = true) {
        let alpha : CGFloat
        if show {
            alpha = 1
        } else {
            alpha = 0
        }
        if placeholderLabel.alpha != alpha {
            if animate {
                UIView.animate(withDuration: 0.4, animations: {
                    self.placeholderLabel.alpha = alpha
                    self.hideBorderView.alpha = alpha
                })
            } else {
                self.placeholderLabel.alpha = alpha
                self.hideBorderView.alpha = alpha
            }
        }
    }
    
    internal func updateError(show : Bool,
                              errorMessage : String?) {
        guard needResultImageView else {
            resultImageView.isHidden = true
            return
        }
        resultImageView.isHidden = false
        if show {
            self.resultImageView.image = UIImage.get(.close)?.withRenderingMode(.alwaysTemplate)
            self.resultImageView.tintColor = configuration.errorColor
            self.borderView.layer.borderColor = configuration.errorColor.cgColor
        } else {
            self.resultImageView.image = UIImage.get(.tickMark)?.withRenderingMode(.alwaysTemplate)
            self.resultImageView.tintColor = configuration.validColor
            self.borderView.layer.borderColor = borderColor.cgColor
        }
        self.errorText = errorMessage
    }
    
    func hideErrorTip() {
        popTip?.hide()
        popTip = nil
    }
    
    func prepareForReuse() {
        borderView.layer.borderColor = borderColor.cgColor
    }
}
