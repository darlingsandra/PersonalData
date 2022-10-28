//
//  CustomButton.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

final class CustomButton: UIButton {
    
    private var borderColor: UIColor {
        didSet {
            setBorderColor()
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            setBorderColor()
        }
    }
    
    // MARK: - init
    required init() {
        borderColor = .systemBlue
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        borderColor = .systemBlue
        super.init(coder: coder)
    }

}

extension CustomButton {
    func configure(title: String, color: UIColor) {
        borderColor = color
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
    }
}

private extension CustomButton {
    func setBorderColor() {
        layer.borderColor = isEnabled ? borderColor.cgColor : UIColor.systemGray5.cgColor
    }
}
