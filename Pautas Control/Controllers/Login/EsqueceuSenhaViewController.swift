//
//  EsqueceuSenhaViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 21/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EsqueceuSenhaViewController: UIViewController, NVActivityIndicatorViewable, Alertable {
    
//    MARK: - Atributos
    private var viewModel: EsqueceuSenhaViewModel = EsqueceuSenhaViewModel()
    let lateralMargins = UIScreen.main.bounds.width * 0.05
    let activityData = ActivityData()
    
//    MARK: - Componentes
    var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    var containerView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var viewContentTitleView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lblSubTitleView: UILabel = {
        var lbl = UILabel()
        lbl.text = Translate.translate("esqueceu_sua_senha_detalhes")
        lbl.font = UIFont(name: "Helvetica", size: 16)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var itemEmailUser: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.05 / 2
        mdc.setShadowColor(.contornoCards, for: .normal)
        mdc.txtField.placeholder = Translate.translate("email")
        mdc.txtField.setIconLeft(icon: "users", color: .lightGray)
        mdc.txtField.keyboardType = .emailAddress
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var btnEnviarEmailResetSenha: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Translate.translate("enviar_email"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        btn.layer.cornerRadius = UIScreen.main.bounds.height * 0.06 / 2
        btn.backgroundColor = .colorPrimaryDark
        return btn
    }()
    
//    MARK: - Ciclo de vida
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .fundoTela
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        bind(to: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
        hideKeyboardTapped()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
//    MARK: - Funções
    func settingLayout(){
        
        view.backgroundColor = .fundoTela
        self.title = Translate.translate("esqueceu_sua_senha")

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lateralMargins),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -lateralMargins),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        containerView.addArrangedSubview(viewContentTitleView)
        
        viewContentTitleView.addSubview(lblSubTitleView)
        NSLayoutConstraint.activate([
            lblSubTitleView.topAnchor.constraint(equalTo: viewContentTitleView.topAnchor, constant: 10),
            lblSubTitleView.leadingAnchor.constraint(equalTo: viewContentTitleView.leadingAnchor),
            lblSubTitleView.trailingAnchor.constraint(equalTo: viewContentTitleView.trailingAnchor),
            lblSubTitleView.bottomAnchor.constraint(equalTo: viewContentTitleView.bottomAnchor, constant: -10)
        ])
        
        containerView.addArrangedSubview(itemEmailUser)
        itemEmailUser.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        itemEmailUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        
        containerView.addArrangedSubview(btnEnviarEmailResetSenha)
        NSLayoutConstraint.activate([
            btnEnviarEmailResetSenha.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.06),
            btnEnviarEmailResetSenha.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            btnEnviarEmailResetSenha.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
        ])
        
        btnEnviarEmailResetSenha.addTarget(self, action: #selector(enviarEmailRecuperacao(_:)), for: .touchUpInside)
    }
    
    @objc func enviarEmailRecuperacao(_ sender: UIButton){
        viewModel.enviarEmailRecuperacao(){ sucesso in
            if sucesso {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.viewModel.loadingType.value = .finish
                    self.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    func bind(to viewModel: EsqueceuSenhaViewModel){
        
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0.first?.message ?? "")}
        viewModel.loadingType.observe(on: self) { [weak self] in self?.loadingState($0)}
        
        itemEmailUser.txtField.bind { self.viewModel.email.value = $0 }
    }
    
    private func loadingState(_ state: ViewModelLoading){
        if state == .loading {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("enviando_reset_senha"))
        }
        
        if state == .send_success {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("email_recuperacao_enviado"))
        }
        
        if state == .finish {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: Constants.APP_NAME, message: error)
    }
}
