//
//  ListAppInputField.swift
//  InputField App
//
//  Created by Rajasekar on 21/03/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

// MARK: - AppListInputProtocol
public protocol AppListInputProtocol : AppInputFieldProtocol {
    func didSelectItem(inputField : AppListInputField,at : Int,value : String)
}

// MARK: - AppListInputField
open class AppListInputField : AppInputField,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    internal lazy var inputCollectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let inputCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        inputCollectionView.translatesAutoresizingMaskIntoConstraints = false
        inputCollectionView.backgroundColor = .clear
        return inputCollectionView
    }()
    
    public var items : [String] = [] {
        didSet {
            itemWidth = []
            totalItemWidth = 0
            for item in items {
                let width = item.width(for : listCellFont) + 50
                itemWidth.append(width)
                totalItemWidth += width
            }
            self.inputCollectionView.reloadData()
        }
    }
    private var totalItemWidth : CGFloat = 0
    private var itemWidth : [CGFloat] = []
    var delegate : AppListInputProtocol? {
        get {
            return inputDelegate as? AppListInputProtocol
        }
        set {
            inputDelegate = newValue
        }
    }
    
    private let listCellFont = UIFont.systemFont(ofSize: 12, weight: .light)
    
    override var stackViewLeftMargin : CGFloat { return 0 }
    override var stackViewRightMargin : CGFloat { return 0 }
    
    override var isValid : Bool {
        return !(self.inputCollectionView.indexPathsForSelectedItems ?? []).isEmpty
    }
    public var listConfiguration : ListFieldConfiguration? { return (configuration as? ListFieldConfiguration)  }
    
    // MARK: - Override methods
    override func addSubViews() {
        super.addSubViews()
        containerView.addArrangedSubview(inputCollectionView)
    }
    
    override func additionalSetUp() {
        super.additionalSetUp()
        
        inputCollectionView.register(ListInputCell.self)
        inputCollectionView.delegate = self
        inputCollectionView.dataSource = self
        inputCollectionView.allowsMultipleSelection = false
        inputCollectionView.allowsSelection = true
        self.updatePlaceholder(showInTop: true,isValidationOn: false,isValid: false)
    }
    
    public func select(at : Int) {
        let selectedIndexPath = IndexPath(item: at, section: 0)
        self.inputCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(ListInputCell.self, for: indexPath)
        cell.update(text : items[indexPath.item],font : listCellFont, configuration: self.listConfiguration ?? ListFieldConfiguration())
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(inputField : self,at : indexPath.item,value : items[indexPath.item])
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let titleWidth = itemWidth[indexPath.item]
        return CGSize(width: titleWidth, height: collectionView.frame.size.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if totalItemWidth < collectionView.frame.size.width {
            return UIEdgeInsets(top: 0, left: (collectionView.frame.size.width - totalItemWidth) / 2.5 , bottom: 0, right: 0)
        } else {
            return UIEdgeInsets.zero
        }
    }
    
    public func update(listUnSelectedColor : UIColor) {
        listConfiguration?.listUnSelectedColor = listUnSelectedColor
        self.inputCollectionView.reloadData()
    }
}
