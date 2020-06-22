//
//  CadastroPautaViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 23/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import NVActivityIndicatorView

class CadastroPautaViewController: UIViewController, Alertable, NVActivityIndicatorViewable {
    
    private var viewModel: CadastrarPautaViewModel = CadastrarPautaViewModel()
    let activityData = ActivityData()

    var lblDescripiton: UILabel = {
        var lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 0.2))
        lbl.fitTextToBounds()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
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
    
    var itemTitulo: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.04 / 2
        mdc.txtField.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        mdc.txtField.placeholder = Translate.translate("title")
        mdc.txtField.font = UIFont.systemFont(ofSize: 16)
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var itemBreveDescricao: ItemTextFieldFormulario = {
        var mdc = ItemTextFieldFormulario()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.04 / 2
        mdc.txtField.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        mdc.txtField.placeholder = Translate.translate("breve_descricao")
        mdc.txtField.font = UIFont.systemFont(ofSize: 16)
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var viewDetalhes: MDCCard = {
        var mdc = MDCCard()
        mdc.cornerRadius = UIScreen.main.bounds.height * 0.05 / 2
        mdc.translatesAutoresizingMaskIntoConstraints = false
        return mdc
    }()
    
    var itemDetalhes: BindingTextView = {
        var textView = BindingTextView()
        textView.setPlaceholder(Translate.translate("detalhes"))
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var btnCadastrarPauta: UIButton = {
        var btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Translate.translate("finaliza_cadastro"), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        btn.layer.cornerRadius = UIScreen.main.bounds.height * 0.06 / 2
        btn.backgroundColor = .colorPrimaryDark
        btn.setTitleColor(.lightGray, for: .disabled)
        btn.isEnabled = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bind(to: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
        hideKeyboardTapped()
    }
    
    func settingLayout(){
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = viewModel.screenTitle
        lblDescripiton.text = viewModel.screenDetails
        
        view.addSubview(lblDescripiton)
        NSLayoutConstraint.activate([
            lblDescripiton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lblDescripiton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            lblDescripiton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: lblDescripiton.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
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
        
        containerView.addArrangedSubview(itemTitulo)
        itemTitulo.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        itemTitulo.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        
        containerView.addArrangedSubview(itemBreveDescricao)
        itemBreveDescricao.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.06).isActive = true
        
        containerView.addArrangedSubview(viewDetalhes)
        viewDetalhes.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.40).isActive = true
        
        viewDetalhes.addSubview(itemDetalhes)
        NSLayoutConstraint.activate([
            itemDetalhes.topAnchor.constraint(equalTo: viewDetalhes.topAnchor, constant: 5),
            itemDetalhes.bottomAnchor.constraint(equalTo: viewDetalhes.bottomAnchor, constant: -5),
            itemDetalhes.leadingAnchor.constraint(equalTo: viewDetalhes.leadingAnchor, constant: 10),
            itemDetalhes.trailingAnchor.constraint(equalTo: viewDetalhes.trailingAnchor, constant: -10)
        ])
        
        
        containerView.addArrangedSubview(btnCadastrarPauta)
        NSLayoutConstraint.activate([
            btnCadastrarPauta.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.06),
            btnCadastrarPauta.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            btnCadastrarPauta.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
        ])
        
        btnCadastrarPauta.addTarget(self, action: #selector(cadatrarPauta(_:)), for: .touchUpInside)
    }
    
    func bind(to viewModel: CadastrarPautaViewModel){
        
        viewModel.cadastroPauta.observe(on: self) { _ in self.checarSeBotaoPodeSerAtivado()}
        viewModel.errorSaving.observe(on: self){ [weak self] in self?.showError($0)}
        viewModel.loadingType.observe(on: self){ [weak self] in self?.loadingState(state: $0)}
        
        itemTitulo.txtField.bind { self.viewModel.cadastroPauta.value.titulo = $0 }
        itemBreveDescricao.txtField.bind { self.viewModel.cadastroPauta.value.breveDescricao = $0 }
        itemDetalhes.bind { self.viewModel.cadastroPauta.value.detalhes = $0 }
    }
    
    private func loadingState(state: ViewModelLoading){
        if state == .saving {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("salvando_pauta"))
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: Constants.APP_NAME, message: error)
    }
    
    func checarSeBotaoPodeSerAtivado(){
        if viewModel.cadastroPauta.value.titulo.isEmpty ||
        viewModel.cadastroPauta.value.breveDescricao.isEmpty ||
            viewModel.cadastroPauta.value.detalhes.isEmpty {
            btnCadastrarPauta.isEnabled = false
        }else {
            btnCadastrarPauta.isEnabled = true
        }
    }
    
    @objc func cadatrarPauta( _ sender: UIButton){
        viewModel.cadastrarPauta(){ sucesso in
            if sucesso{
                NVActivityIndicatorPresenter.sharedInstance.setMessage(Translate.translate("pauta_salva_com_suceeso"))
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                })
            }else {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
        }
    }
}

