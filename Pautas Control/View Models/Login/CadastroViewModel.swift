//
//  CadastroViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

protocol CadastroViewModelInput {
    
    func criarUsuario(completion: @escaping(_ sucesso: Bool) -> ())
}

protocol CadastroViewModelOutput {
    
    var cadastroUser: Observable<Cadastro> { get }
    var confirmPassword: Observable<String> { get }
    var erros: Observable<[BrokenRule]> { get }
    var loadingType: Observable<ViewModelLoading> { get }
    var title: String { get }
    var isValid: Bool { get }
}

struct CadastroViewModel: CadastroViewModelInput, CadastroViewModelOutput {
   
//    MARK: Outputs
    var title: String = Translate.translate("vamos_comecar")
    
    var cadastroUser: Observable<Cadastro> = Observable(
        Cadastro(
            nome: "",
            email: "",
            password: ""
        )
    )
    
    var confirmPassword: Observable<String> = Observable("")
    
    var loadingType: Observable<ViewModelLoading> = Observable(.none)
    
    var erros: Observable<[BrokenRule]> = Observable([])
    
    var isValid: Bool {
        get {
            self.erros.value = [BrokenRule]()
            self.validar()
            return self.erros.value.count == 0 ? true : false
        }
    }
    
//    MARK: - Inputs
    func criarUsuario(completion: @escaping (Bool) -> ()) {
        loadingType.value = .saving
        if isValid {
            AuthFirebase().criarNovoUsuario(cadastro: cadastroUser.value){ result, error in
                if error == nil {
                    completion(true)
                    self.loadingType.value = .saving_success
                }else {
                    completion(false)
                    self.loadingType.value = .finish
                    self.erros.value.append(
                        BrokenRule(
                            propertyName: "error_create_account",
                            message: Translate.translate("error_cadastrar_verifique_email")
                        )
                    )
                }
            }
        }else {
            completion(false)
            self.loadingType.value = .finish
        }
    }
    
    private func validar(){
        
        var errors = [BrokenRule]()
        
        if cadastroUser.value.nome.isEmpty {
            errors.append(
                BrokenRule(
                    propertyName: "nameUser",
                    message: Translate.translate("error_nome_nao_preenchido")
                )
            )
        }
        
        if cadastroUser.value.email.isEmpty && cadastroUser.value.password.isEmpty {
            errors.append(
                BrokenRule(
                    propertyName: "emailUser&passwordUser",
                    message: Translate.translate("error_email_senha_nao_preenchido")
                )
            )
        }
        
        if cadastroUser.value.email.isEmpty {
            errors.append(
                BrokenRule(
                    propertyName: "emailUser",
                    message: Translate.translate("error_email_nao_preenchido")
                )
            )
        }
        
        if cadastroUser.value.email.isValidEmail() == false {
            errors.append(
                BrokenRule(
                    propertyName: "emailUser",
                    message: Translate.translate("error_email_nao_valido")
                )
            )
        }
        
        if cadastroUser.value.password.isEmpty {
            errors.append(
                BrokenRule(
                    propertyName: "passwordUser",
                    message: Translate.translate("error_senha_nao_preenchido")
                )
            )
        }
        
        if confirmPassword.value.isEmpty {
            errors.append(
                BrokenRule(
                    propertyName: "passwordUser",
                    message: Translate.translate("error_confirmar_senha_nao_preenchido")
                )
            )
        }
        
        if cadastroUser.value.password != confirmPassword.value {
            errors.append(
                BrokenRule(
                    propertyName: "passwordUser",
                    message: Translate.translate("error_senha_nao_igual")
                )
            )
        }
        
        if cadastroUser.value.password.count < 8 {
            errors.append(
                BrokenRule(
                    propertyName: "passwordUser",
                    message: Translate.translate("error_senha_muito_curta")
                )
            )
        }
        
        self.erros.value = errors
    }
}
