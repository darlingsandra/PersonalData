//
//  AppDelegate.swift
//  PersonalData
//
//  Created by Александра Широкова on 27.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let personVC = PersonViewController()
        let presenter = PersonPresenter(view: personVC)
        personVC.presenter = presenter
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = personVC
        window?.makeKeyAndVisible()
        return true
    }

}

