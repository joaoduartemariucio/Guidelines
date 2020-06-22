//
//  LoginViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

protocol LoginViewModelInput {
    
    func fazerLoginUser(completion: @escaping( _ sucesso: Bool) -> ())
}

protocol LoginViewModelOutput {
    
    var loginUser: Observable<Login> { get }
    var erros: Observable<[BrokenRule]> { get }
    var loadingType: Observable<ViewModelLoading> { get }
    var isValid: Bool { get }
}

struct LoginViewModel: LoginViewModelInput, LoginViewModelOutput {
    
//    MARK: Outputs
    var loginUser: Observable<Login> = Observable(
        Login(
            email: "",
            password: ""
        )
    )
    
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
    func fazerLoginUser(completion: @escaping (Bool) -> ()) {
        loadingType.value = .loading
        if isValid {
            AuthFirebase().realizarLogin(login: loginUser.value) { sucesso, message in
                if sucesso {
                    completion(true)
                }else {
                    completion(false)
                    self.erros.value.append(BrokenRule(propertyName: "login", message: message!))
                }
                self.loadingType.value = .finish
            }
        }else {
            completion(false)
            self.loadingType.value = .finish
        }
    }
    
    private func validar(){
        
        var errors = [BrokenRule]()
        
        if !loginUser.value.email.isValidEmail() {
            errors.append(BrokenRule(propertyName: "emailUser", message: Translate.translate("error_email_nao_valido")))
        }
        
        if loginUser.value.password.isEmpty {
            errors.append(
                BrokenRule(
                    propertyName: "passwordUser",
                    message: Translate.translate("error_senha_nao_preenchido")
                )
            )
        }
        
        self.erros.value = errors
    }
}
