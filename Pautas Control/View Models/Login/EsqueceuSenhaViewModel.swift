//
//  EsqueceuSenhaViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 21/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

protocol EsqueceuSenhaViewModelInput {
    
    func enviarEmailRecuperacao(completion: @escaping(_ sucesso: Bool) -> ())
}

protocol EsqueceuSenhaViewModelOutput {
    
    var email: Observable<String> { get }
    var error: Observable<[BrokenRule]> { get }
    var loadingType: Observable<ViewModelLoading> { get }
    var isValid: Bool { get }
}

struct EsqueceuSenhaViewModel: EsqueceuSenhaViewModelInput, EsqueceuSenhaViewModelOutput {
    
    var email: Observable<String> = Observable("")
    var error: Observable<[BrokenRule]> = Observable([])
    var loadingType: Observable<ViewModelLoading> = Observable(.none)
    
    var isValid: Bool {
        get {
            self.error.value = [BrokenRule]()
            self.validar()
            return self.error.value.count == 0 ? true : false
        }
    }
    
    func enviarEmailRecuperacao(completion: @escaping (Bool) -> ()) {
        loadingType.value = .loading
        if isValid {
            AuthFirebase().esqueceuSenha(email: email.value){ sucesso, message in
                if sucesso {
                    self.loadingType.value = .send_success
                    completion(true)
                }else {
                    self.loadingType.value = .finish
                    completion(false)
                }
            }
        }else {
            loadingType.value = .finish
            completion(false)
        }
    }

    private func validar(){
        
        var errors = [BrokenRule]()
        
        if email.value.isEmpty {
            errors.append(BrokenRule(propertyName: "emailUser", message: Translate.translate("error_email_nao_preenchido")))
        }
        
        if !email.value.isValidEmail() {
            errors.append(BrokenRule(propertyName: "emailUser", message: Translate.translate("error_email_nao_valido")))
        }
        
        error.value = errors
    }
}
