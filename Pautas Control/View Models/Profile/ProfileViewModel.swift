//
//  PerfilViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol ProfileViewModelInput {
    
    func viewWillAppear()
    func deslogarApp(completion: @escaping( _ sucesso: Bool) -> Void)
}

protocol ProfileViewModelOutput {
    
    var name: Observable<String> { get }
    var email: Observable<String> { get }
    var loadingType: Observable<ViewModelLoading> { get }
    var erros: Observable<String> { get }
}

struct ProfileViewModel: ProfileViewModelInput, ProfileViewModelOutput {
    
//    MARK: - Outputs
    var name: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var loadingType: Observable<ViewModelLoading> = Observable(.none)
    var erros: Observable<String> = Observable("")

//    MARK: - Inputs
    
    func viewWillAppear() {
        loadingType.value = .loading
        AuthFirebase().userInfo { user, error in 
            if let username = user?.username, let email = user?.email {
                self.name.value = username
                self.email.value = email
            }
            self.loadingType.value = .finish
        }
    }
    
    func deslogarApp(completion: @escaping( _ sucesso: Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch  {
            completion(false)
            erros.value = Translate.translate("error_deslogar_app")
        }
    }
}
