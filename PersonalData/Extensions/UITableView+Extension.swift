//
//  UITableView+Extension.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

extension UITableView {
    func registerCell<T>(ofType type: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
    func dequeueCell<T>(ofType type: T.Type) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
}
