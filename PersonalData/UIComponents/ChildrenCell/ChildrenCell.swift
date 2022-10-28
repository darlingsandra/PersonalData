//
//  ChildrenCell.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

protocol ChildrenCellDelegate: AnyObject {
    func childNameChanged(_ id: String, value: String)
    func childAgeChanged(_ id: String, value: String)
    func childDeleted(_ id: String)
}

final class ChildrenCell: UITableViewCell {
    
    weak var delegate: ChildrenCellDelegate?
    var id: String = ""
    
    // MARK: - IBOutlet
    @IBOutlet weak var nameView: CustomTextField!
    @IBOutlet weak var ageView: CustomTextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == nameView.textField, let value = textField.text {
            delegate?.childNameChanged(id, value: value)
        }
        if textField == ageView.textField, let value = textField.text {
            delegate?.childAgeChanged(id, value: value)
        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
//        nameView.textField.endEditing(true)
//        ageView.textField.endEditing(true)
        delegate?.childDeleted(id)
    }
}

extension ChildrenCell {
    func configure(_ id: String, name: String, age: String) {
        self.id = id
        
        nameView.placeHolder.text = "Имя"
        ageView.placeHolder.text = "Возраст"
        
        nameView.textField.text = name
        ageView.textField.text = age
    
        selectionStyle = .none
        
        nameView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        ageView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchDown)
        
        ageView.textField.keyboardType = .asciiCapableNumberPad
    }
}
