//
//  NavigationController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func setTitle(title: String){
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.topItem?.title = title
    }
    
    func setColor(cor: UIColor){
        guard let navigation = self.navigationController else { return }
        
        navigation.navigationBar.isTranslucent = false
        
        let navBarAppearance = UINavigationBar.appearance()
        
        navBarAppearance.barTintColor = cor
        
        navBarAppearance.barStyle = .default
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    func addShadow(cor: UIColor){
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.layer.shadowColor = cor.cgColor
        navigation.navigationBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        navigation.navigationBar.layer.shadowRadius = 2.0
        navigation.navigationBar.layer.shadowOpacity = 1.0
    }
}
