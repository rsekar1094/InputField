//
//  AppInputFieldTableViewCell.swift
//  InputField App
//
//  Created by Rajasekar on 16/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - AppInputFieldType
public enum AppInputFieldType : Int {
    case textField
    case passwordField
    case phoneField
    case list
    case arrowList
}

// MARK: - AppInputFieldTableViewCell
open class AppInputFieldTableViewCell : InputFieldBaseTableViewCell {
    
    private static var defaultConfiguration : InputFieldConfiguration?
    
    
    // MARK: - Properties
    internal var type : AppInputFieldType { return .textField }
    open weak var inputFieldView : AppInputField?
    
    // MARK: - Initi
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUp()
    }
    
    // MARK: - Methods
    private func setUp() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        let defaultConfiguration  : InputFieldConfiguration = AppInputFieldTableViewCell.defaultConfiguration ?? InputFieldConfiguration()
        
        let view : AppInputField
        switch type {
        case .textField:
            view = AppTextField(configuration: defaultConfiguration)
        case .phoneField:
            view = AppPhoneTextField(configuration : defaultConfiguration)
        case .passwordField:
            view = AppPasswordTextField(configuration : defaultConfiguration)
        case .list:
            view = AppListInputField(configuration : defaultConfiguration)
        case .arrowList:
            view = DropListAppInputField(configuration : defaultConfiguration)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        view.g_pinEdges()
        self.inputFieldView = view
    }
    
    public func updateOnCellConfigure(errorMessage : String?,canShowValidationResult : Bool) {
        inputFieldView?.updateOnConfigure(errorMessage: errorMessage, canShowValidationResult: canShowValidationResult)
    }
    
    public func update(tag : Int) {
        self.inputFieldView?.tag = tag
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        inputFieldView?.prepareForReuse()
    }
    
    public static func setDefaultConfiguration(_ defaultConfiguration : InputFieldConfiguration?) {
        AppInputFieldTableViewCell.defaultConfiguration = defaultConfiguration
    }
}
