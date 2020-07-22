//
//  BaseTableViewCell.swift
//  InputField App
//
//  Created by Rajasekar on 01/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

public enum CellAdjustInset {
    case left
    case right
    case bothLeftRight
    case none
}

open class BaseTableViewCell: UITableViewCell {

    weak var baseView : UIView?
    var cellInset : CellAdjustInset = .none
    private static let offsetWidth : CGFloat = 400
    private static let offsetMargin : CGFloat = 40
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.preservesSuperviewLayoutMargins = false
        baseView?.layoutMargins = UIEdgeInsets.zero // UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 100)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let insets = BaseTableViewCell.getEdgeInset(width : self.frame.width,cellInset : cellInset)
        if let baseView = baseView,baseView.layoutMargins != insets {
            baseView.layoutMargins = insets
        }
        
    }
    
    public static func getEdgeInset(width : CGFloat,cellInset : CellAdjustInset) -> UIEdgeInsets {
        let currentWidth = width
        let requiredWidth = currentWidth * 0.8
        
        if currentWidth > offsetWidth + offsetMargin {
            switch cellInset {
            case .left:
                let leftInset = currentWidth - requiredWidth
                return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
            case .right:
                let rightInset = currentWidth - requiredWidth
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: rightInset)
            case .bothLeftRight:
                let inset = (currentWidth - requiredWidth) / 2
               return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
            case .none:
                return UIEdgeInsets.zero
            }
        } else {
            return UIEdgeInsets.zero
        }
    }

}

