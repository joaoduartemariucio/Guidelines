//
//  CadastroPautaViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 23/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol CadastroPautaViewModelInput {
    
    func cadastrarPauta(completion: @escaping(_ sucesso: Bool) -> ())
}

protocol CadastroPautaViewModelOutput {
    
    var loadingType: Observable<ViewModelLoading> { get }
    var cadastroPauta: Observable<Pauta> { get }
    var errorSaving: Observable<String> { get }
    
    var errors: [String] { get }
    var screenTitle: String { get }
    var screenDetails: String { get }
    var isValid: Bool { get }
}

protocol CadastroPautaViewModel: CadastroPautaViewModelInput, CadastroPautaViewModelOutput { }

final class CadastrarPautaViewModel: CadastroPautaViewModel {
    
    var loadingType: Observable<ViewModelLoading> = Observable(.none)
    var errorSaving: Observable<String> = Observable("")
    var errors: [String] = []
    
    var cadastroPauta: Observable<Pauta> = Observable(
        Pauta(
            id: 0,
            titulo:"",
            breveDescricao: "",
            detalhes: "",
            autor: "",
            finalizada: false
        )
    )
    
    var screenTitle: String = Translate.translate("cadastro_pauta")
    
    var screenDetails: String = Translate.translate("cadastro_pauta_detalhes")
    
    var isValid: Bool {
        get {
            self.errors = [String]()
            validar()
            return errors.count == 0 ? true : false
        }
    }
    
    private func validar(){
        if cadastroPauta.value.titulo.isEmpty {
            errors.append("sem_titulo")
        }
        
        if cadastroPauta.value.breveDescricao.isEmpty {
            errors.append("sem_breve_decricao")
        }
        
        if cadastroPauta.value.detalhes.isEmpty {
            errors.append("sem_detalhes")
        }
    }
    
    func cadastrarPauta(completion: @escaping(_ sucesso: Bool) -> ()) {
        self.loadingType.value = .saving
        if isValid {
            AuthFirebase().cadastrarNovaPauta(pauta: cadastroPauta.value){ sucesso in
                self.loadingType.value = .finish
                completion(sucesso)
                if !sucesso {
                    self.errorSaving.value = Translate.translate("error_salvar_tente_novamente")
                }
            }
        }
    }
}
