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
    let children: [Child]?
}

struct Child {
    let name: String
    let age: Int
}
