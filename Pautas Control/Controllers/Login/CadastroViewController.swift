//
//  CadastroViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import FirebaseAuth
import MaterialComponents.MaterialCards
import NVActivityIndicatorView

class CadastroViewController: UIViewController, NVActivityIndicatorViewable, Alertable {

//    MARK: - Atributos
    let viewModel: CadastroViewModel = CadastroViewModel()
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
        lbl.text = Translate.translate("vamos_comecar_detalhes").replacingOccurrences(of: "**", with: Constants.APP_NAME)
        lbl.font = UIFont(name: "Helvetica", size: 16)
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var itemNameUser: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.05 / 2
        mdc.setShadowColor(.contornoCards, for: .normal)
        mdc.txtField.placeholder = Translate.translate("nome")
        mdc.txtField.setIconLeft(icon: "users", color: .lightGray)
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var itemEmailUser: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.05 / 2
        mdc.setShadowColor(.contornoCards, for: .normal)
        mdc.txtField.placeholder = Translate.translate("email")
        mdc.txtField.setIconLeft(icon: "communications", color: .lightGray)
        mdc.txtField.keyboardType = .emailAddress
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var itemPasswordUser: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.05 / 2
        mdc.setShadowColor(.contornoCards, for: .normal)
        mdc.txtField.placeholder = Translate.translate("senha")
        mdc.txtField.setIconLeft(icon: "lock", color: .lightGray)
        mdc.txtField.isSecureTextEntry = true
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var itemConfirmPasswordUser: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.05 / 2
        mdc.setShadowColor(.contornoCards, for: .normal)
        mdc.txtField.placeholder = Translate.translate("confirmar_senha")
        mdc.txtField.setIconLeft(icon: "lock", color: .lightGray)
        mdc.txtField.isSecureTextEntry = true
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var btnCadastrar: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Translate.translate("criar_conta"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        btn.layer.cornerRadius = UIScreen.main.bounds.height * 0.06 / 2
        btn.backgroundColor = .colorPrimaryDark
        return btn
    }()
    
//    MARK: - Ciclo de vida
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
        
        self.title = viewModel.title

        view.backgroundColor = .fundoTela
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        
        containerView.addArrangedSubview(itemNameUser)
        itemNameUser.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        itemNameUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true

        containerView.addArrangedSubview(itemEmailUser)
        itemEmailUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        
        containerView.addArrangedSubview(itemPasswordUser)
        itemPasswordUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true

        containerView.addArrangedSubview(itemConfirmPasswordUser)
        itemConfirmPasswordUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true

        containerView.addArrangedSubview(btnCadastrar)
        NSLayoutConstraint.activate([
            btnCadastrar.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.06),
            btnCadastrar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            btnCadastrar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
        ])
        
        btnCadastrar.addTarget(self, action: #selector(cadastrarNovoUsuario(_:)), for: .touchUpInside)
    }
    
    func bind(to viewModel: CadastroViewModel){
        
        viewModel.loadingType.observe(on: self){ [weak self] in self?.loadingState($0)}
        viewModel.erros.observe(on: self) { [ weak self] in self?.showError($0.first?.message ?? "")}
        
        itemNameUser.txtField.bind { self.viewModel.cadastroUser.value.nome = $0 }
        itemEmailUser.txtField.bind { self.viewModel.cadastroUser.value.email = $0 }
        itemPasswordUser.txtField.bind { self.viewModel.cadastroUser.value.password = $0 }
        itemConfirmPasswordUser.txtField.bind { self.viewModel.confirmPassword.value = $0 }
    }
    
    private func loadingState(_ state: ViewModelLoading){
        if state == .saving {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("criando_seu_login"))
        }
        
        if state == .saving_success {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("cadastrado_com_sucesso"))
        }
        
        if state == .finish {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    @objc func cadastrarNovoUsuario(_ sender: UIButton){
        viewModel.criarUsuario(){ sucesso in
            if sucesso {
                self.sucessoCriarLogin()
            }
        }
    }
    
    func sucessoCriarLogin(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.viewModel.loadingType.value = .finish
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: Constants.APP_NAME, message: error)
    }
}
