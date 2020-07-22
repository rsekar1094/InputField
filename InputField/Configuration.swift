//
//  Configuration.swift
//  InputField
//
//  Created by Rajasekar on 22/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit
open class Configuration {
    let tintColor : UIColor
    let textColor : UIColor
    let parentViewColor : UIColor
    let defaultBorderColor : UIColor
    let errorColor : UIColor
    let validColor : UIColor
    
    public init(tintColor : UIColor = UIColor.blue,
                textColor : UIColor = UIColor.black,
                parentViewColor : UIColor = UIColor.white,
                defaultBorderColor : UIColor = UIColor.blue,
                errorColor : UIColor = UIColor.red,
                validColor : UIColor = UIColor.green) {
        self.tintColor = tintColor
        self.textColor = textColor
        self.parentViewColor = parentViewColor
        self.defaultBorderColor = defaultBorderColor
        self.errorColor = errorColor
        self.validColor = validColor
    }
}


open class ListConfiguration : Configuration {
    let listUnSelectedColor : UIColor
    
    public init(tintColor : UIColor = UIColor.blue,
                textColor : UIColor = UIColor.black,
                parentViewColor : UIColor = UIColor.white,
                defaultBorderColor : UIColor = UIColor.blue,
                errorColor : UIColor = UIColor.red,
                validColor : UIColor = UIColor.green,
                listUnSelectedColor : UIColor = UIColor.blue.withAlphaComponent(0.5)) {
        self.listUnSelectedColor = listUnSelectedColor
        super.init(tintColor: tintColor,
                   textColor : textColor,
                   parentViewColor : parentViewColor,
                   defaultBorderColor: defaultBorderColor,
                   errorColor: errorColor, validColor: validColor)
    }
    
}

open class PhoneConfiguration : Configuration {
    let defaultCountryPhoneCode : String
    
    public init(tintColor : UIColor = UIColor.blue,
                textColor : UIColor = UIColor.black,
                parentViewColor : UIColor = UIColor.white,
                defaultBorderColor : UIColor = UIColor.blue,
                errorColor : UIColor = UIColor.red,
                validColor : UIColor = UIColor.green,
                defaultCountryPhoneCode : String) {
        self.defaultCountryPhoneCode = defaultCountryPhoneCode
        super.init(tintColor: tintColor,
                   textColor : textColor,
                   parentViewColor : parentViewColor,
                   defaultBorderColor: defaultBorderColor,
                   errorColor: errorColor, validColor: validColor)
    }
}
