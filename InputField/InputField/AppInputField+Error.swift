//
//  AppInputField+Error.swift
//  InputField
//
//  Created by Rajasekar on 25/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit
extension AppInputField {
    private func update(isValidationOn: Bool,
                             errorMessage : String?,reloadIfNeed : Bool) {
        self.errorText = errorMessage
        let isErrorLabelHidden = bottomErrorLabel.isHidden
        
        let isError = errorMessage != nil
        updateborder(isValidationOn: isValidationOn, isValid: !isError)
        
        guard isValidationOn else {
            resultImageView.isHidden = true
            bottomErrorLabel.isHidden = true
            
            if reloadIfNeed && !isErrorLabelHidden {
                self.inputDelegate?.reloadNeed(for: self)
            }
            return
        }
        
        if isError {
            switch configuration.errorShowType {
            case .inside:
                resultImageView.isHidden = false
                bottomErrorLabel.isHidden = true
                if isError {
                    self.resultImageView.image = UIImage.get(.close)?.withRenderingMode(.alwaysTemplate)
                } else {
                    self.resultImageView.image = UIImage.get(.tickMark)?.withRenderingMode(.alwaysTemplate)
                }
                if reloadIfNeed && !isErrorLabelHidden {
                    self.inputDelegate?.reloadNeed(for: self)
                }
            case .outsideDownLeft,.outsideDownRight:
                self.bottomErrorLabel.text = errorMessage
                
                self.resultImageView.isHidden = true
                self.bottomErrorLabel.isHidden = false
                if reloadIfNeed && isErrorLabelHidden {
                    self.inputDelegate?.reloadNeed(for: self)
                }
            }
        } else {
            self.resultImageView.isHidden = true
            self.bottomErrorLabel.isHidden = true
            if reloadIfNeed && !isErrorLabelHidden {
                self.inputDelegate?.reloadNeed(for: self)
            }
        }
    }
    
    internal func updateError(errorMessage : String?,reloadIfNeed : Bool) {
        update(isValidationOn: self.isValidationOn, errorMessage: errorMessage, reloadIfNeed: reloadIfNeed)
    }
    
    @objc
    public func prepareForReuse() {
        self.inputDelegate = nil
        update(isValidationOn : false,errorMessage: nil, reloadIfNeed: false)
    }
    
    public func updateOnConfigure(errorMessage : String?,
                       canShowValidationResult : Bool) {
        let showAllpossibleError = (self.inputDelegate?.showPossibleErrorForAll ?? false)
        update(isValidationOn: canShowValidationResult || showAllpossibleError, errorMessage: errorMessage, reloadIfNeed: false)
    }
}
