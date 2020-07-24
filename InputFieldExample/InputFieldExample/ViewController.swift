//
//  ViewController.swift
//  InputFieldExample
//
//  Created by Rajasekar on 24/07/20.
//  Copyright © 2020 rsekhar. All rights reserved.
//

import UIKit
import InputField
class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        self.tableView.register(AppTextFieldTableViewCell.self)
        self.tableView.register(AppPasswordFieldTableViewCell.self)
        self.tableView.register(AppPhoneNumberTableViewCell.self)
        self.tableView.register(AppListTableViewCell.self)
        self.tableView.register(AppDropListTableViewCell.self)
    }
    
    internal var showPossibleErrorForAll: Bool = false
    internal var textChangedIndexPaths : [IndexPath] = []
    
    private var enteredValue : [IndexPath:String] = [:]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeue(AppTextFieldTableViewCell.self)
            cell.update(returnType: .done)
            cell.update(tag : indexPath.item)
            
            let isValid = self.isValid(indexPath: indexPath, text: enteredValue[indexPath] ?? "")
            let isValidationOn = canShowValidationResult(indexPath: indexPath)
            
            cell.update(placeholder: "Email", text: enteredValue[indexPath],
                        isValidationOn: isValidationOn,isValid : isValid.0, delegate: self)
            cell.inputFieldView?.update(errorShowType: .outsideDownLeft)
            cell.update(isOptional: false)
            cell.updateOnCellConfigure(errorMessage: isValid.1, canShowValidationResult: isValidationOn)
            // cell.updateErrorOrSuccessOnTimeOfDisplay()
            return cell
        case 1:
            let cell = tableView.dequeue(AppPasswordFieldTableViewCell.self)
            cell.update(returnType: .done)
            cell.update(tag : indexPath.item)
            cell.inputFieldView?.update(errorShowType: .inside)
            
            let isValid = self.isValid(indexPath: indexPath, text: enteredValue[indexPath] ?? "")
            let isValidationOn = canShowValidationResult(indexPath: indexPath)
            
            cell.update(placeholder: "Password", text: enteredValue[indexPath],
                        isValidationOn: isValidationOn,isValid : isValid.0, delegate: self)
            cell.updateOnCellConfigure(errorMessage: isValid.1, canShowValidationResult: isValidationOn)
            cell.update(isOptional: false)
            return cell
        case 2:
            let cell = tableView.dequeue(AppPhoneNumberTableViewCell.self)
            cell.update(returnType: .done)
            cell.update(tag : indexPath.item)
            cell.inputFieldView?.update(errorShowType: .outsideDownRight)
            
            let isValid = self.isValid(indexPath: indexPath, text: enteredValue[indexPath] ?? "")
            let isValidationOn = canShowValidationResult(indexPath: indexPath)
            
            cell.update(placeholder: "Phone", text: enteredValue[indexPath],
                        isValidationOn: isValidationOn,isValid : isValid.0,delegate: self)
            cell.updateOnCellConfigure(errorMessage: isValid.1, canShowValidationResult: isValidationOn)
            cell.update(isOptional: false)
            cell.update(countryCode: "+91")
            return cell
        case 4:
            let cell = tableView.dequeue(AppListTableViewCell.self)
            cell.update(tag : indexPath.item)
            
            let isValid = self.isValid(indexPath: indexPath, text: enteredValue[indexPath] ?? "")
            let isValidationOn = canShowValidationResult(indexPath: indexPath)
            
            cell.update(placeholder: "Items", items: ["skk","fdfd","dfdfdf"], selectedPosition: 1, delegate: self)
            cell.updateOnCellConfigure(errorMessage: isValid.1, canShowValidationResult: isValidationOn)
            return cell
        case 3:
            let cell = tableView.dequeue(AppDropListTableViewCell.self)
            cell.update(tag : indexPath.item)
            cell.update(placeholder: "Email", text: enteredValue[indexPath], delegate: self)
            cell.updateOnCellConfigure(errorMessage: isValid(indexPath: indexPath, text: enteredValue[indexPath] ?? "").1, canShowValidationResult: canShowValidationResult(indexPath: indexPath))
            return cell
        default:
            let cell = tableView.dequeue(AppTextFieldTableViewCell.self)
            cell.update(tag : indexPath.item)
            cell.update(returnType: .done)
            
            let isValid = self.isValid(indexPath: indexPath, text: enteredValue[indexPath] ?? "")
            let isValidationOn = canShowValidationResult(indexPath: indexPath)
            
            cell.update(placeholder: "Email\(indexPath.item)", text: enteredValue[indexPath],
                        isValidationOn: isValidationOn,isValid : isValid.0,delegate: self)
            cell.inputFieldView?.update(errorShowType: .outsideDownLeft)
            cell.update(isOptional: indexPath.item % 2 == 0)
            cell.updateOnCellConfigure(errorMessage: isValid.1, canShowValidationResult: isValidationOn)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}

extension ViewController : AppInputFieldProtocol,AppTextFieldProtocol,AppListInputProtocol {
    
    
    var inputFieldController: UIViewController {
        return self
    }
    
    func didTextChange(inputField: AppTextField, text: String) {
        guard let indexPath = self.tableView.indexPath(for: inputField) else {
            return
        }
        print("didTextChange : \(indexPath.item)")
        
        textChangedIndexPaths.append(indexPath)
        enteredValue[indexPath] = text
    }
    
    func isValid(inputField: AppTextField, text: String) -> (Bool, String?) {
        guard let indexPath = self.tableView.indexPath(for: inputField) else {
            return (true,nil)
        }
        
        print("isValid : \(indexPath.item)")
        
        return isValid(indexPath: indexPath, text: text)
    }
    
    func isValid(indexPath : IndexPath,text : String) -> (Bool, String?) {
        if indexPath.item % 2 == 0 {
            return (true,nil)
        } else  {
            if text.isEmpty {
                return (false,"invalid")
            } else{
                return (true,nil)
            }
        }
    }
    
    func shouldEndEditing(inputField: AppTextField) -> Bool {
        return true
    }
    
    func shouldReturn(inputField: AppTextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }
    
    func canShowValidationResult(inputField: AppInputField) -> Bool {
        guard let indexPath = self.tableView.indexPath(for: inputField) else {
            return false
        }
        print("canShowValidationResult : \(indexPath.item)")
        return canShowValidationResult(indexPath : indexPath)
    }
    
    private func canShowValidationResult(indexPath : IndexPath) -> Bool {
        return textChangedIndexPaths.contains(indexPath)
    }
    
    func didSelectItem(inputField: AppListInputField, at: Int, value: String) {
        
    }
    
    func reloadNeed(for inputField : AppInputField) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}


extension UITableView {
    func indexPath(for view: UIView) -> IndexPath? {
        let viewCenterRelativeToTableview = self.convert(CGPoint.init(x: view.bounds.midX, y: view.bounds.midY), from:view)
        return self.indexPathForRow(at: viewCenterRelativeToTableview)
    }
}
