//
//  Pautas.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

struct Pauta: Codable, Equatable, Identifiable {
    
    var id: Int
    var titulo: String
    var breveDescricao: String
    var detalhes: String
    var autor: String
    var finalizada: Bool
}
