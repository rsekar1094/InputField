//
//  UIView+Extensions.swift
//  InputField App
//
//  Created by Rajasekar on 01/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @discardableResult
    func g_pin(on type1: NSLayoutConstraint.Attribute,
                                  view: UIView? = nil,
                                  on type2: NSLayoutConstraint.Attribute? = nil,
                                  constant: CGFloat = 0,
                                  priority: Float? = nil,
                                  needToActivate : Bool = true) -> NSLayoutConstraint? {
        guard let view = view ?? superview else {
            return nil
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        let type2 = type2 ?? type1
        let constraint = NSLayoutConstraint(item: self, attribute: type1,
                                            relatedBy: .equal,
                                            toItem: view, attribute: type2,
                                            multiplier: 1, constant: constant)
        if let priority = priority {
            constraint.priority = UILayoutPriority(rawValue: priority)
        }
        
        if needToActivate {
            constraint.isActive = true
        }
        
        return constraint
    }
    
    @discardableResult
    func g_pinEdges(view: UIView? = nil,needToActivate : Bool = true,inset : UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        
        var constraints : [NSLayoutConstraint]  = []
        if let topConstraint = g_pin(on: .top, view: view,constant : inset.top, needToActivate : false) {
            constraints.append(topConstraint)
        }
        if let bottomConstraint = g_pin(on: .bottom, view: view,constant : inset.bottom, needToActivate : false) {
            constraints.append(bottomConstraint)
        }
        if let leftConstraint = g_pin(on: .left, view: view,constant : inset.left, needToActivate : false) {
            constraints.append(leftConstraint)
        }
        if let rightConstraint = g_pin(on: .right, view: view,constant : inset.right, needToActivate : false) {
            constraints.append(rightConstraint)
        }
        
        if needToActivate {
            NSLayoutConstraint.activate(constraints)
        }
        
        return constraints
    }
}
