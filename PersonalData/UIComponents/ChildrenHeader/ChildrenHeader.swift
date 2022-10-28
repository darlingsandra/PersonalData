//
//  ChildrenHeader.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

final class ChildrenHeader: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addChildButton: CustomButton!
    
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
private extension ChildrenHeader {
    func setupContentView() {
        Bundle.main.loadNibNamed(String(describing: ChildrenHeader.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addChildButton.configure(title: "Добавить ребенка", color: .systemBlue)
    }
}
