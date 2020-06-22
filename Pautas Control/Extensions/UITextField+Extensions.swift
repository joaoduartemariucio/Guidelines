//
//  TextField.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setIconLeft(icon: String, color: UIColor){
        let iconView = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = UIImage(named: icon)?.withRenderingMode(.alwaysTemplate)
        let iconContainerView: UIView = UIView(frame: CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        iconContainerView.tintColor = color
        leftView = iconContainerView
        leftViewMode = .always
    }
}
