//
//  DropListAppInputField.swift
//  InputField App
//
//  Created by Rajasekar on 22/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - DropListAppInputField
open class DropListAppInputField : AppInputField {
    
    // MARK: - Properties
    internal lazy var inputLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = self.configuration.textColor
        return label
    }()
    
    internal lazy var dropArrowImageView : UIImageView = {
        let dropArrowImageView = UIImageView()
        dropArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        dropArrowImageView.contentMode = .scaleAspectFit
        dropArrowImageView.image = UIImage.get(.dropArrow)?.withRenderingMode(.alwaysTemplate)
        dropArrowImageView.tintColor = borderColor
        return dropArrowImageView
    }()
    
    public var text : String? {
        get {
            return inputLabel.text
        }
        set {
            inputLabel.text = newValue
        }
    }
    
    override var isValid : Bool {
        return !(text ?? "").isEmpty
    }
    
    // MARK: - Override methods
    override func addSubViews() {
        super.addSubViews()
        
        containerView.addArrangedSubview(inputLabel)
        containerView.addArrangedSubview(dropArrowImageView)
    }
    
    override func additionalSetUp() {
        super.additionalSetUp()
        
    }
    
    override func getConstraints() -> [NSLayoutConstraint] {
        var constraints = super.getConstraints()
        constraints.append(dropArrowImageView.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(dropArrowImageView.heightAnchor.constraint(equalToConstant: 20))
        return constraints
    }
    
}
