//
//  UIImage+SysImages.swift
//  InputField App
//
//  Created by Vivek R on 05/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

enum IconType : Int {
    case tickMark
    case dropArrow
    case eye
    case eyeSlash
    case close
}

extension UIImage {
    
    static func get(_ type : IconType) -> UIImage? {
        switch type {
        case .tickMark:
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "checkmark")
            } else {
                return UIImage.init(named : "checkmark")
            }
        case .dropArrow:
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "chevron.down")
            } else {
                return UIImage.init(named : "dropArrow")
            }
        case .eye:
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "eye.fill")
            } else {
                return UIImage.init(named : "eye")
            }
        case .eyeSlash:
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "eye.slash.fill")
            } else {
                return UIImage.init(named : "eyeSlash")
            }
        case .close:
            if #available(iOS 13.0, *) {
                return UIImage(systemName: "xmark")
            } else {
                return UIImage.init(named : "close")
            }
        }
    }
    
}
