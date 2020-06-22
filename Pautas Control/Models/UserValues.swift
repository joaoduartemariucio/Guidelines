//
//  UserValues.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 24/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

struct UserValues: Codable {
    
    var username: String
    var email: String
    var pautas: [Pauta]
}
