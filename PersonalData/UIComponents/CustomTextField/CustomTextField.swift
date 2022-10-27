//
//  CustomTextField.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

final class CustomTextField: UIView {
   
    // MARK: - IBOutlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var placeHolder: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContentView()
    }
    
}

// MARK: - Private method
private extension CustomTextField {
    func setupContentView() {
        Bundle.main.loadNibNamed(String(describing: CustomTextField.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray6.cgColor
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
