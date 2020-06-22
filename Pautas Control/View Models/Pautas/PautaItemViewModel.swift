//
//  PautaItemViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 23/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

struct PautaItemViewModel: Equatable {
    
    let id: Int
    var titulo: String
    var breveDescricao: String
    var detalhes: String
    var autor: String
    var finalizada: Bool
}

extension PautaItemViewModel {
    
    init(pauta: Pauta) {
        self.id = pauta.id
        self.titulo = pauta.titulo
        self.breveDescricao = pauta.breveDescricao
        self.detalhes = pauta.detalhes
        self.autor = pauta.autor
        self.finalizada = pauta.finalizada
    }
    
    func pauta() -> Pauta {
        return Pauta(
            id: self.id,
            titulo: self.titulo,
            breveDescricao: self.breveDescricao,
            detalhes: self.detalhes,
            autor: self.autor,
            finalizada: self.finalizada
        )
    }
}
