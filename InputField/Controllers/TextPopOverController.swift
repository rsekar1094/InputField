//
//  TextPopOverController.swift
//  InputField
//
//  Created by Rajasekar on 24/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit

class TextPopOverController : UIViewController {
    
    // MARK: - Static methods
    static func present(text : String,
                        configuration : InputFieldConfiguration,
                        sourceView : UIView,
                        popVertically : Bool = true,
                        backgroundColor : UIColor = .white,
                        presentingController : UIViewController,dismissCompletion : (()->Void)?)  {
        let vc = TextPopOverController(text: text,configuration : configuration,
                                       dismissCompletion : dismissCompletion)
        vc.view.backgroundColor = backgroundColor
        let point = presentingController.view.convert(CGPoint.init(x: sourceView.bounds.midX, y: sourceView.bounds.midY), from:sourceView)
        vc.modalPresentationStyle = .popover
        let view = presentingController.view!
        if let popoverPresentationController = vc.popoverPresentationController {
            
            popoverPresentationController.permittedArrowDirections = popVertically ? (point.y > (view.frame.height / 2) ? .down : .up) : (point.x > (view.frame.width / 2) ? .right : .left)
            
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(origin: point, size: CGSize(width: sourceView.frame.width / 2, height: sourceView.frame.height / 2))
            popoverPresentationController.delegate = vc
        }
        let width : CGFloat = 300
        let height = text.height(for: width, font: UIFont.systemFont(ofSize: 16, weight: .regular)) + 20
        vc.preferredContentSize = CGSize(width: width, height: height)
        presentingController.present(vc, animated: true, completion: nil)
    }
    
    private let text : String
    private let configuration : InputFieldConfiguration
    private var dismissCompletion : (()->Void)?
    
    init(text : String,configuration : InputFieldConfiguration,dismissCompletion : (()->Void)?) {
        self.text = text
        self.configuration = configuration
        self.dismissCompletion = dismissCompletion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal lazy var textView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        textView.text = text
        textView.textColor = configuration.textColor
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(textView)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            textView.g_pinEdges()
        }
    }
    
}
extension TextPopOverController : UIPopoverPresentationControllerDelegate {
    //UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        dismissCompletion?()
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}
