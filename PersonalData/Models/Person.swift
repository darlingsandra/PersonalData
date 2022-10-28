//
//  Person.swift
//  PersonalData
//
//  Created by Александра Широкова on 28.10.2022.
//

import Foundation

struct Person {
    let name: String
    let age: Int
    var children: [Child]
    
    init(name: String, age: Int, children: [Child]) {
        self.name = name
        self.age = age
        self.children = children
    }
        
    init() {
        self.name = ""
        self.age = 0
        self.children = []
    }
    
    func changeValues(name: String? = nil, age: Int? = nil, children: [Child]? = nil) -> Person {
        return Person(
            name: name ?? self.name,
            age: age ?? self.age,
            children: children ?? self.children
        )
    }
}

struct Child {
    let id: String
    let name: String
    let age: Int
    let parent: Person
    
    init(name: String, age: Int, parent: Person) {
        self.id = UUID().uuidString
        self.parent = parent
        self.name = name
        self.age = age
    }
    
    init(parent: Person) {
        self.id = UUID().uuidString
        self.parent = parent
        self.name = ""
        self.age = 0
    }
    
    private init(id: String, name: String, age: Int, parent: Person) {
        self.parent = parent
        self.id = id
        self.name = name
        self.age = age
    }
    
    func changeValues(name: String? = nil, age: Int? = nil, parent: Person? = nil) -> Child {
        return Child(
            id: self.id,
            name: name ?? self.name,
            age: age ?? self.age,
            parent: parent ?? self.parent
        )
    }
}

extension Child: Equatable {
    static func ==(lhs: Child, rhs: Child) -> Bool {
        return lhs.id == rhs.id
    }
}

