//
//  CustomButton.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

final class CustomButton: UIButton {

    // MARK: - init
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension CustomButton {
    func configure(title: String, color: UIColor) {
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
    }
}
