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
open class AppInputFieldTableViewCell : BaseTableViewCell {
    
    // MARK: - Properties
    internal var type : AppInputFieldType { return .textField }
    internal weak var inputFieldView : AppInputField?
    internal var configuration : Configuration { return Configuration()  }
    
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
            view = AppTextField(configuration: configuration)
        case .phoneField:
            view = AppPhoneTextField(configuration: configuration)
        case .passwordField:
            view = AppPasswordTextField(configuration: configuration)
        case .list:
            view = AppListInputField(configuration : configuration)
        case .arrowList:
            view = DropListAppInputField(configuration : configuration)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        view.g_pinEdges()
        self.inputFieldView = view
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        
        inputFieldView?.prepareForReuse()
    }
}
