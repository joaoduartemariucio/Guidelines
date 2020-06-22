//
//  LoginViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController, NVActivityIndicatorViewable, Alertable {
    
//    MARK: - Atributos
    private var viewModel: LoginViewModel = LoginViewModel()
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
    
    var logoProjeto: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var viewContentTitleView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lblTitleView: UILabel = {
        var lbl = UILabel()
        lbl.text = Translate.translate("seja_bem_vindo")
        lbl.font = UIFont(name: "Helvetica-Bold", size: 26)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var lblSubTitleView: UILabel = {
        var lbl = UILabel()
        lbl.text = Translate.translate("seja_bem_vindo_detalhes").replacingOccurrences(of: "**", with: Constants.APP_NAME)
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
    
    var viewForgotPassword: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var btnForgotPassword: UIButton = {
        var btn = UIButton()
        btn.setTitle(Translate.translate("esqueceu_sua_senha"), for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var btnLogin: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("LOGIN", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        btn.layer.cornerRadius = UIScreen.main.bounds.height * 0.06 / 2
        btn.backgroundColor = .colorPrimaryDark
        return btn
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
        self.navigationController?.navigationBar.isHidden = true
        bind(to: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
        hideKeyboardTapped()
    }
    
//    MARK: - Funções
    func settingLayout(){
        
        view.backgroundColor = .fundoTela
        
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
        
        containerView.addArrangedSubview(logoProjeto)
        NSLayoutConstraint.activate([
            logoProjeto.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.15),
            logoProjeto.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            logoProjeto.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        containerView.addArrangedSubview(viewContentTitleView)
        
        viewContentTitleView.addSubview(lblTitleView)
        NSLayoutConstraint.activate([
            lblTitleView.topAnchor.constraint(equalTo: viewContentTitleView.topAnchor, constant: 10),
            lblTitleView.leadingAnchor.constraint(equalTo: viewContentTitleView.leadingAnchor),
            lblTitleView.trailingAnchor.constraint(equalTo: viewContentTitleView.trailingAnchor)
        ])
        
        viewContentTitleView.addSubview(lblSubTitleView)
        NSLayoutConstraint.activate([
            lblSubTitleView.topAnchor.constraint(equalTo: lblTitleView.bottomAnchor, constant: 10),
            lblSubTitleView.leadingAnchor.constraint(equalTo: viewContentTitleView.leadingAnchor),
            lblSubTitleView.trailingAnchor.constraint(equalTo: viewContentTitleView.trailingAnchor),
            lblSubTitleView.bottomAnchor.constraint(equalTo: viewContentTitleView.bottomAnchor, constant: -10)
        ])
        
        containerView.addArrangedSubview(itemEmailUser)
        itemEmailUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        
        containerView.addArrangedSubview(itemPasswordUser)
        itemPasswordUser.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true

        containerView.addArrangedSubview(viewForgotPassword)
        
        viewForgotPassword.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        viewForgotPassword.addSubview(btnForgotPassword)
        NSLayoutConstraint.activate([
            btnForgotPassword.topAnchor.constraint(equalTo: viewForgotPassword.topAnchor),
            btnForgotPassword.trailingAnchor.constraint(equalTo: viewForgotPassword.trailingAnchor),
            btnForgotPassword.bottomAnchor.constraint(equalTo: viewForgotPassword.bottomAnchor)
        ])
        
        containerView.addArrangedSubview(btnLogin)
        NSLayoutConstraint.activate([
            btnLogin.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.06),
            btnLogin.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            btnLogin.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
        ])
        
        containerView.addArrangedSubview(btnCadastrar)
        NSLayoutConstraint.activate([
            btnCadastrar.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.06),
            btnCadastrar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            btnCadastrar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
        ])
        
        btnForgotPassword.addTarget(self, action: #selector(irParaTelaEnviarEmailRecuperacao(_:)), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(fazerLoginUsuario(_:)), for: .touchUpInside)
        btnCadastrar.addTarget(self, action: #selector(irParaTelaCadastroUsuario(_:)), for: .touchUpInside)
    }
    
    func bind(to viewModel: LoginViewModel){
        
        viewModel.erros.observe(on: self){ [weak self] in self?.showError($0.first?.message ?? "")}
        viewModel.loadingType.observe(on: self) { [weak self] in self?.loadingState($0)}
        
        itemEmailUser.txtField.bind { self.viewModel.loginUser.value.email = $0 }
        itemPasswordUser.txtField.bind { self.viewModel.loginUser.value.password = $0 }
    }
    
    @objc func fazerLoginUsuario(_ sender: UIButton){
        viewModel.fazerLoginUser() { sucesso in
            if sucesso {
                self.irParaTelaInicial()
            }
        }
    }
    
    private func loadingState(_ state: ViewModelLoading){
        if state == .loading {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("processando_login"))
        }
        if state == .finish {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: Constants.APP_NAME, message: error)
    }
    
    func irParaTelaInicial(){
        let inicio = InicialViewController()
        UIApplication.shared.keyWindow?.rootViewController = inicio
    }
    
    @objc func irParaTelaEnviarEmailRecuperacao(_ sender: UIButton){
        self.navigationController?.pushViewController(EsqueceuSenhaViewController(), animated: true)
    }

    @objc func irParaTelaCadastroUsuario(_ sender: UIButton){
        self.navigationController?.pushViewController(CadastroViewController(), animated: true)
    }
}
