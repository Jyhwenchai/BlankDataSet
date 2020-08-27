//
//  AppDelegate.swift
//  BlankDataSet
//
//  Created by 蔡志文 on 2020/8/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        BlankDataSet.configure()
        
        return true
    }

}

