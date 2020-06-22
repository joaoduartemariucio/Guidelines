//
//  Translate.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 21/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation


class Translate {
    
    class func translate(_ key: String) -> String {
        let userdefaults = UserDefaults.standard
        if let path = Bundle.main.path(forResource: userdefaults.string(forKey: Constants.Forkeys.LINGUAGE_USER), ofType: "lproj"){
            if let bundle = Bundle(path: path) {
                return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
            }
        }
        return NSLocalizedString(key, comment: "")
    }
    
    class func setLanguage(_ language: String) {
        let userdefaults = UserDefaults.standard
        userdefaults.set(language, forKey: Constants.Forkeys.LINGUAGE_USER)
        userdefaults.synchronize()
    }
}
