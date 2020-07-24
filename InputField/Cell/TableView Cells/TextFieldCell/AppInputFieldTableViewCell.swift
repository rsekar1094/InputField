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
        
        let view : AppInputField
        switch type {
        case .textField:
            view = AppTextField()
        case .phoneField:
            view = AppPhoneTextField()
        case .passwordField:
            view = AppPasswordTextField()
        case .list:
            view = AppListInputField()
        case .arrowList:
            view = DropListAppInputField()
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
}
