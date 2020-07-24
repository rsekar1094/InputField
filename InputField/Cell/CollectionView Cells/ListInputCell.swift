//
//  File.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
class ListInputCell : UICollectionViewCell {
    
    // MARK: - Properties
    internal lazy var label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private var configuration = ListFieldConfiguration()
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.layer.cornerRadius = label.frame.size.height / 2
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.backgroundColor = configuration.focusedColor
            } else {
                label.backgroundColor = configuration.listUnSelectedColor
            }
        }
    }
    
    // MARK: - Methods
    private func setUp() {
        self.addSubview(label)
        label.g_pinEdges(inset : UIEdgeInsets.init(top: 8, left: 10, bottom: -8, right: -10))
    }
    
    public func update(text : String,font : UIFont,configuration : ListFieldConfiguration) {
        self.configuration = configuration
        label.text = text
        label.font = font
        label.textColor = UIColor.white
        label.backgroundColor = configuration.listUnSelectedColor
    }
    
}
