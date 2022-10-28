//
//  PersonViewController.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

protocol PersonViewProtocol: AnyObject {
    func updateChildren()
}

final class PersonViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var nameView: CustomTextField!
    @IBOutlet weak var ageView: CustomTextField!
    @IBOutlet weak var clearButton: CustomButton!
    @IBOutlet weak var headerView: ChildrenHeader!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var presenter: PersonPresenterProtocol!
    
    private let maxChild = 5
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == nameView.textField, let name = textField.text {
            presenter.personNameChanged(name)
        }
        if textField == ageView.textField, let age = textField.text {
            presenter.personAgeChanged(age)
        }
    }
    
    @objc func addChildButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        presenter.childAdded()
        setVisibleAddChild()
    }
    
    @objc func clearButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        let alert = UIAlertController()
        let actionClear = UIAlertAction(title: "Сбросить данные", style: .default) { _ in
            self.nameView.textField.text = ""
            self.ageView.textField.text = ""
            
            self.presenter.clearDataTapped()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(actionClear)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func updatePositionView(notification: NSNotification) {
        guard let userInfo = notification.userInfo as? [String: Any],
              let keybourdFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomConstraint.constant = 16
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification  {
            bottomConstraint.constant = keybourdFrame.height
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        presenter.getCountChild()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ofType: ChildrenCell.self)
        if tableView.numberOfRows(inSection: indexPath.section) - 1 == indexPath.row {
            cell.separatorInset = .zero
        }
        cell.delegate = self
        cell.configure(
            presenter.getIDChild(index: indexPath.row),
            name: presenter.getNameChild(index: indexPath.row),
            age: presenter.getAgeChild(index: indexPath.row)
        )
        return cell
    }
}

// MARK: - PersonViewProtocol
extension PersonViewController: PersonViewProtocol {
    func updateChildren() {
        tableView.reloadData()
        setVisibleAddChild()
    }
}

// MARK: - ChildrenCellDelegate
extension PersonViewController: ChildrenCellDelegate {
    func childNameChanged(_ id: String, value: String) {
        presenter.childNameChanged(id, name: value)
    }
    
    func childAgeChanged(_ id: String, value: String) {
        presenter.childAgeChanged(id, age: value)
    }
    
    func childDeleted(_ id: String) {
        view.endEditing(true)
        presenter.childDeleted(id: id)
    }
}

// MARK: - Private method
private extension PersonViewController {
    func configureView() {
        nameView.placeHolder.text = "Имя"
        ageView.placeHolder.text = "Возраст"
        
        tableView.registerCell(ofType: ChildrenCell.self)
        clearButton.configure(title: "Очистить", color: .red)
        
        nameView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        ageView.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        clearButton.addTarget(self, action: #selector(clearButtonTapped(_:)), for: .touchDown)
        headerView.addChildButton.addTarget(self, action: #selector(addChildButtonTapped(_:)), for: .touchDown)
        
        ageView.textField.keyboardType = .asciiCapableNumberPad
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updatePositionView(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
                
        NotificationCenter.default.addObserver(self,
            selector: #selector(updatePositionView(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func setVisibleAddChild() {
        self.headerView.addChildButton.isEnabled = !(self.presenter.getCountChild() >= self.maxChild)
    }
}
