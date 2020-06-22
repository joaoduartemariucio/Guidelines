//
//  ItemFormulario.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class ItemTextFieldFormulario: MDCCard {
    
    var txtField: BindingTextField = {
        var txt = BindingTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingLayout(){
        
        self.addSubview(txtField)
        NSLayoutConstraint.activate([
            txtField.topAnchor.constraint(equalTo: self.topAnchor),
            txtField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            txtField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            txtField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
