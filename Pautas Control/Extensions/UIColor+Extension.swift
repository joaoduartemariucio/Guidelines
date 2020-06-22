//
//  Colors.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

extension UIColor {

    open class var colorPrimary: UIColor {
        get {
            return UIColor(red: 0.21, green: 0.55, blue: 0.95, alpha: 1.00)
        }
    }
    
    open class var colorPrimaryDark: UIColor {
        get {
            return UIColor(red: 0.00, green: 0.38, blue: 0.75, alpha: 1.00)
        }
    }
    
    open class var colorPrimaryLight: UIColor {
        get {
            return UIColor(red: 0.47, green: 0.74, blue: 1.00, alpha: 1.00)
        }
    }
    
    open class var fundoTela: UIColor {
        get {
            return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
        }
    }
    
    open class var contornoCards: UIColor {
        get {
            return UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1.00)
        }
    }

    open class var verde: UIColor {
        get {
            return UIColor(red: 0.00, green: 0.78, blue: 0.33, alpha: 1.00)
        }
    }
}
