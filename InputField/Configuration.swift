//
//  Configuration.swift
//  InputField
//
//  Created by Rajasekar on 22/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit

public enum ErrorShowType : Int {
    case inside
    case outsideDownLeft
    case outsideDownRight
}


open class InputFieldConfiguration {
    public var focusedColor : UIColor = UIColor.blue
    public var unfocusedColor : UIColor = UIColor.black
    
    public var textColor : UIColor = UIColor.black
    public var parentViewColor : UIColor = UIColor.white
    public var errorColor : UIColor = UIColor.red
    public var validColor : UIColor = UIColor.green
    public var errorShowType : ErrorShowType = .outsideDownLeft
    
    public var isOptional : Bool = false
    public var placeholder : String = ""
    
    public var placeholderFont : UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
    public var focusedPlaceholderFont : UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    public var placehoderColor : UIColor = UIColor.darkGray.withAlphaComponent(0.5)
    
    public var fieldHeight : CGFloat = 47
    
    public init() {
        
    }
    
    
}


open class ListFieldConfiguration : InputFieldConfiguration {
    public var listUnSelectedColor : UIColor
    
    public init(listUnSelectedColor : UIColor = UIColor.blue.withAlphaComponent(0.5)) {
        self.listUnSelectedColor = listUnSelectedColor
        super.init()
    }
    
}

open class PhoneFieldConfiguration : InputFieldConfiguration {
    public var defaultCountryPhoneCode : String
    
    public init(defaultCountryPhoneCode : String) {
        self.defaultCountryPhoneCode = defaultCountryPhoneCode
        super.init()
    }
}
