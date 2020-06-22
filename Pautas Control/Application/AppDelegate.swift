//
//  AppDelegate.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if Auth.auth().currentUser == nil {
            let inicio = LoginViewController()
            window?.rootViewController = UINavigationController(rootViewController: inicio)
            window?.makeKeyAndVisible()
        }else {
            let inicio = InicialViewController()
            window?.rootViewController = inicio
            window?.makeKeyAndVisible()
        }
        
        return true
    }
}

