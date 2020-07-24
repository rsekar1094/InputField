//
//  String+Extensions.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

extension String {
    func width(for font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func height(for width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return actualSize.height
    }
}
