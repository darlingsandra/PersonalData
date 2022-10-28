//
//  PersonPresenter.swift
//  PersonalData
//
//  Created by Александра Широкова on 28.10.2022.
//

import Foundation

protocol PersonPresenterProtocol {
    func personNameChanged(_ name: String)
    func personAgeChanged(_ age: String)

    func getCountChild() -> Int
    func getIDChild(index: Int) -> String
    func getNameChild(index: Int) -> String
    func getAgeChild(index: Int) -> String
    
    func childAdded()
    func childNameChanged(_ id: String, name: String)
    func childAgeChanged(_ id: String, age: String)
    func childDeleted(id: String)
    
    func clearDataTapped()
}

final class PersonPresenter {
    
    private unowned let view: PersonViewProtocol
    private var person: Person
    
    init(view: PersonViewProtocol) {
        self.view = view
        self.person = Person()
    }
}

extension PersonPresenter: PersonPresenterProtocol {
    func personNameChanged(_ name: String) {
        person = person.changeValues(name: name)
    }
    
    func personAgeChanged(_ age: String) {
        person = person.changeValues(age: Int(age))
    }
    
    func getCountChild() -> Int {
        person.children.count
    }
    
    func getIDChild(index: Int) -> String {
        guard person.children.count > index else { return "" }
        return person.children[index].id
    }
    
    func getNameChild(index: Int) -> String {
        guard person.children.count > index else { return "" }
        return person.children[index].name
    }
    
    func getAgeChild(index: Int) -> String {
        guard person.children.count > index, person.children[index].age > 0 else { return "" }
        return String(person.children[index].age)
    }
    
    func childAdded() {
        person.children.append(Child(parent: person))
        view.updateChildren()
    }
    
    func childNameChanged(_ id: String, name: String) {
        guard let child = person.children.filter({ $0.id == id }).first,
              let index = person.children.firstIndex(of: child) else { return }
        person.children[index] = child.changeValues(name: name)
    }

    func childAgeChanged(_ id: String, age: String) {
        guard let child = person.children.filter({ $0.id == id }).first,
              let index = person.children.firstIndex(of: child) else { return }
        person.children[index] = child.changeValues(age: Int(age))
    }
    
    func childDeleted(id: String) {
        guard let child = person.children.filter({ $0.id == id }).first,
              let index = person.children.firstIndex(of: child) else { return }
        person.children.remove(at: index)
        view.updateChildren()
    }
    
    func clearDataTapped() {
        person = Person()
        view.updateChildren()
    }
}
