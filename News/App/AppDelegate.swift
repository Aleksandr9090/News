//
//  AppDelegate.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit
import NewsPack

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func applicationWillTerminate(_ application: UIApplication) {
        StorageManager.shared.saveContext()
    }
}
