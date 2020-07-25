//
//  AppInputField+ViewSetup.swift
//  InputField
//
//  Created by Rajasekar on 25/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit
extension AppInputField {
    
    // MARK: - View Methods
    @objc
    internal func addSubViews() {
        self.addSubview(verticalContainerView)
        verticalContainerView.addArrangedSubview(borderView)
        verticalContainerView.addArrangedSubview(bottomErrorLabel)
        borderView.addSubview(containerView)
        self.addSubview(hideBorderView)
        self.addSubview(placeholderLabel)
    }
    
    @objc
    internal func getConstraints() -> [NSLayoutConstraint] {
        var constraints : [NSLayoutConstraint] = []
        
        //verticalContainerView
        constraints.append(verticalContainerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10))
        constraints.append(verticalContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10))
        constraints.append(verticalContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10))
        let verticalBottomConstraint = verticalContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -5)
        verticalBottomConstraint.priority = UILayoutPriority.init(900)
        constraints.append(verticalBottomConstraint)
        
        //borderView
        constraints.append(borderView.heightAnchor.constraint(equalToConstant: fieldHeight))
        
        //containerView
        constraints.append(containerView.heightAnchor.constraint(equalToConstant: fieldHeight-2))
        constraints.append(containerView.centerYAnchor.constraint(equalTo: borderView.centerYAnchor))
        constraints.append(containerView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor,constant: stackViewLeftMargin))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor,constant: -stackViewRightMargin))
        
        //hideBorderView
        constraints.append(hideBorderView.heightAnchor.constraint(equalToConstant : 2))
        constraints.append(hideBorderView.leadingAnchor.constraint(equalTo: placeholderLabel.leadingAnchor,constant: -4))
        constraints.append(hideBorderView.trailingAnchor.constraint(equalTo: placeholderLabel.trailingAnchor,constant: 4))
        constraints.append(hideBorderView.bottomAnchor.constraint(equalTo: borderView.topAnchor,constant: 2))
        
        //placeholderLabel
        constraints.append(placeholderLabel.leadingAnchor.constraint(equalTo: borderView.leadingAnchor,constant: placeholderLeftMargin))
        
        //TODO
        /*let bottomErrorLabelLeadingConstraint = bottomErrorLabel.leadingAnchor.constraint(equalTo: verticalContainerView.leadingAnchor,constant: placeholderLeftMargin)
        bottomErrorLabelLeadingConstraint.priority = UILayoutPriority.init(999)
        constraints.append(bottomErrorLabelLeadingConstraint)
        
        let bottomErrorLabelTrailingConstraint = bottomErrorLabel.trailingAnchor.constraint(equalTo: verticalContainerView.trailingAnchor)
        bottomErrorLabelTrailingConstraint.priority = UILayoutPriority.init(999)
        constraints.append(bottomErrorLabelTrailingConstraint)*/
        
        return constraints
    }
}
