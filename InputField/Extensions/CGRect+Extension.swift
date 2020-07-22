//
//  CGRect+Extension.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        get {
            return CGPoint(x: self.midX, y: self.midY)
        }
        set {
            self.origin.x = newValue.x - width/2
            self.origin.y = newValue.y - height/2
        }
    }
}
