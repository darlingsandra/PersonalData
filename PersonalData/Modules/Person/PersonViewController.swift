//
//  PersonViewController.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

final class PersonViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var nameView: CustomTextField!
    @IBOutlet weak var ageView: CustomTextField!
    @IBOutlet weak var clearButton: CustomButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureView()
    }
    
}

// MARK: - Private method
private extension PersonViewController {
    func configureView() {
        nameView.placeHolder.text = "Имя"
        ageView.placeHolder.text = "Возраст"
        
        tableView.registerCell(ofType: ChildrenCell.self)
        clearButton.configure(title: "Очистить", color: .red)
    }
}

// MARK: - UITableViewDelegate
extension PersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: ChildrenCell.self)
        if tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.row {
            cell.separatorInset = .zero
        }
        cell.configure()
        return cell
    }
}
