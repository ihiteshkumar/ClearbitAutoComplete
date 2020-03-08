//
//  AppDelegate.swift
//  ClearbitAutoComplete
//
//  Created by Hitesh Kumar on 08/03/20.
//  Copyright © 2020 Hitesh Kumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else {
            return false
        }
        let navigationController = UINavigationController(rootViewController: CompanySearchView())
        applyGlobalAppearanceOnSearchBar()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        return true
    }

    func applyGlobalAppearanceOnSearchBar() {
        let barButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        barButtonItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

