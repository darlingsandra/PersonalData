//
//  ChildrenCell.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

final class ChildrenCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nameView: CustomTextField!
    @IBOutlet weak var ageView: CustomTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ChildrenCell {
    func configure() {
        nameView.placeHolder.text = "Имя"
        ageView.placeHolder.text = "Возраст"
        
        selectionStyle = .none
    }
}
