//
//  InicialViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit

class InicialViewController: UITabBarController {
    
    var viewControllersList = [
        PautasAbertasViewController(),
        PautasFechadasViewController(),
        ProfileViewController()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
        
        viewControllersList[0].tabBarItem.image = UIImage(named: "pauta-aberta")
        viewControllersList[0].tabBarItem.title = Translate.translate("pautas_abertas")
        
        viewControllersList[1].tabBarItem.image = UIImage(named: "pauta-finalizada")
        viewControllersList[1].tabBarItem.title = Translate.translate("pautas_fechadas")
        
        viewControllersList[2].tabBarItem.image = UIImage(named: "perfil")
        viewControllersList[2].tabBarItem.title = Translate.translate("perfil")
        
        self.viewControllers = viewControllersList.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
