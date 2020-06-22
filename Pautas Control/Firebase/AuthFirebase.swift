//
//  AuthFirebase.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthFirebase {
    
    func criarNovoUsuario(cadastro: Cadastro, callback: @escaping(_ authResult: AuthDataResult?, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: cadastro.email, password: cadastro.password) { authResult, error in
            self.salvarNomeUsuario(nome: cadastro.nome){ success in
                try? Auth.auth().signOut()
            }
            callback(authResult, error)
        }
    }
    
    func realizarLogin(login: Login, callback:@escaping(_ sucesso: Bool, _ message: String?) -> ()){
        Auth.auth().signIn(withEmail: login.email, password: login.password) { authResult, error in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code){
                    switch errorCode {
                    case .userNotFound:
                        callback(false, Translate.translate("error_email_invalido"))
                        break
                    case .wrongPassword:
                        callback(false, Translate.translate("error_senha_invalida"))
                        break
                    default:
                        callback(false, Translate.translate("error_nao_tratado"))
                        break
                    }
                }
            }else {
                callback(true, nil)
            }
        }
    }
    
    func esqueceuSenha(email: String, callback: @escaping(_ sucesso: Bool, _ message: String?) -> ()){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code){
                    switch errorCode {
                    case .userNotFound:
                        callback(false, Translate.translate("error_email_invalido"))
                        break
                    default:
                        callback(false, Translate.translate("error_nao_tratado"))
                        break
                    }
                }
            }else {
                callback(true, nil)
            }
        }
    }
    
    func salvarNomeUsuario(nome: String, callback: @escaping (_ success: Bool) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        let db = Firestore.firestore()
        let ref = db.collection("users")
        
        ref.document(user.uid).setData([
            "username": nome,
            "email": user.email!,
            "pautas": []
        ]){ error in
            if let err = error {
                print("Error adding document: \(err)")
                callback(false)
            }else {
                print("Document added with ID: \(ref.collectionID)")
                callback(true)
            }
        }
    }
    
    
    func uidUser() -> String {
        guard let uid = Auth.auth().currentUser?.uid else { return "" }
        return uid
    }
    
    func userInfo(completion: @escaping (_ userInfo: UserValues?, _ error: Error?) -> ()) {
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(self.uidUser())
        
        docRef.getDocument { (document, error) in
            if let err = error {
                completion(nil, err)
            }else {
                if let data = try? JSONSerialization.data(withJSONObject: document!.data(), options: []) {
                    guard let decode = DecodeData.decode(UserValues.self, data: data) else { return }
                    completion(decode, error)
                }
            }
        }
    }
    
    func cadastrarNovaPauta(pauta: Pauta, completion: @escaping(_ sucesso: Bool) -> ()){
        let db = Firestore.firestore()
        let ref = db.collection("users").document(self.uidUser())
        
        self.userInfo { userinfos, error in
            
            if var userInfos = userinfos {
                var pautaCadastrar = pauta
                pautaCadastrar.id = userInfos.pautas.count+1
                pautaCadastrar.autor = userInfos.username
                userInfos.pautas.append(pautaCadastrar)
                guard let userEncode = try? userInfos.asDictionary() else { return }
                ref.updateData(userEncode)
                completion(true)
            }
            
            if error != nil {
                completion(false)
            }
        }
    }
    
    func editarPauta(pauta: Pauta, finalizar: Bool, completion: @escaping(_ sucesso: Bool) -> ()){
        let db = Firestore.firestore()
        let ref = db.collection("users").document(self.uidUser())
        
        self.userInfo { userinfos, error in
            
            if var userInfos = userinfos {
                for i in 0..<userInfos.pautas.count {
                    if pauta.id == userInfos.pautas[i].id {
                        userInfos.pautas[i].finalizada = finalizar
                        guard let userEncode = try? userInfos.asDictionary() else {
                            completion(false)
                            return
                        }
                        ref.updateData(userEncode)
                        completion(true)
                        return
                    }
                }
            }
            
            if error != nil {
                completion(false)
            }
        }
    }
}
