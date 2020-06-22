//
//  ProfileViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class ProfileViewController: UIViewController, Alertable {
    
    var viewModel = ProfileViewModel()
    
    var cardProfile: MDCCard = {
        var card = MDCCard()
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }()
    
    var lblNomeUser: UILabel = {
        var lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.fitTextToBounds()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lblEmailUser: UILabel = {
        var lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.fitTextToBounds()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var btnDeslogar: UIButton = {
        var btn = UIButton()
        btn.setTitle(Translate.translate("deslogar"), for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bind(to: viewModel)
        viewModel.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
    }
    
    func settingLayout(){
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = Translate.translate("perfil")
        
        view.addSubview(cardProfile)
        NSLayoutConstraint.activate([
            cardProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            cardProfile.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cardProfile.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        cardProfile.addSubview(lblNomeUser)
        NSLayoutConstraint.activate([
            lblNomeUser.topAnchor.constraint(equalTo: cardProfile.topAnchor, constant: 15),
            lblNomeUser.leadingAnchor.constraint(equalTo: cardProfile.leadingAnchor, constant: 15),
            lblNomeUser.trailingAnchor.constraint(equalTo: cardProfile.trailingAnchor, constant: -15),
        ])
        
        cardProfile.addSubview(lblEmailUser)
        NSLayoutConstraint.activate([
            lblEmailUser.topAnchor.constraint(equalTo: lblNomeUser.bottomAnchor, constant: 10),
            lblEmailUser.leadingAnchor.constraint(equalTo: cardProfile.leadingAnchor, constant: 15),
            lblEmailUser.trailingAnchor.constraint(equalTo: cardProfile.trailingAnchor, constant: -15),
            lblEmailUser.bottomAnchor.constraint(equalTo: cardProfile.bottomAnchor, constant: -15)
        ])
        
        view.addSubview(btnDeslogar)
        NSLayoutConstraint.activate([
            btnDeslogar.topAnchor.constraint(equalTo: cardProfile.bottomAnchor),
            btnDeslogar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            btnDeslogar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            btnDeslogar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        btnDeslogar.addTarget(self, action: #selector(logOut(_:)), for: .touchUpInside)
    }
    
    func bind(to viewModel: ProfileViewModel){
        viewModel.name.observe(on: self) { [weak self] in self?.setNomeUser($0) }
        viewModel.email.observe(on: self) { [weak self] in self?.setEmailUser($0) }
        viewModel.loadingType.observe(on: self) { [weak self] in self?.loadingState($0) }
        viewModel.erros.observe(on: self) { [weak self] in self?.showError($0)}
    }
    
    private func setNomeUser(_ nome: String){
        lblNomeUser.text = "\(Translate.translate("nome")): \n\(nome)"
    }
    
    private func setEmailUser(_ email: String){
        lblEmailUser.text = "\(Translate.translate("email")): \n\(email)"
    }
    
    private func loadingState(_ state: ViewModelLoading){
        if state == .loading {
            
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: Constants.APP_NAME, message: error)
    }
    
    @objc func logOut(_ sender: UIButton){
        viewModel.deslogarApp(){ sucesso in
            if sucesso {
                let login = LoginViewController()
                login.hidesBottomBarWhenPushed = true
                self.navigationController?.setViewControllers([login], animated: true)
            }
        }
    }
}
