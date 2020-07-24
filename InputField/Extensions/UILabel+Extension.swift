//
//  UILabel.swift
//  InputField
//
//  Created by Rajasekar on 25/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit

extension UILabel {
    func animate(font: UIFont, duration: TimeInterval) {
        // let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldFrame = self.frame
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin = frame.origin
        frame.origin = oldFrame.origin // only for left aligned text
        // frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y) // only for right aligned text
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.frame.origin = newOrigin
            self.transform = .identity
            self.layoutIfNeeded()
        }
    }
}
