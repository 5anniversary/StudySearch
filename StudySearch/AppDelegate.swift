//
//  AppDelegate.swift
//  StudySearch
//
//  Created by Junhyeon on 2020/03/29.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        debugPrint("start application")
        
        FirebaseApp.configure()
        return true
    }
    
    
    
}

