//
//  PautasFechadasViewController.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class PautasFechadasViewController: UIViewController, Alertable {
    
    private var viewModel: DefaultListaPautasViewModel = DefaultListaPautasViewModel()
    
    var isOpened: [Bool] = [Bool]()
    
    var lblDescripiton: UILabel = {
        var lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 0.2))
        lbl.fitTextToBounds()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var tableView: UITableView = {
        var table = UITableView()
        table.register(PautasViewCell.self, forCellReuseIdentifier: PautasViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.isEnabled = true
        table.allowsSelection = false
        table.refreshControl?.addTarget(self, action: #selector(atualizarListaPautasAbertas(_:)), for: .valueChanged)
        return table
    }()
    
    var btnAdicionarNovaPauta: MDCFloatingButton = {
        var btn = MDCFloatingButton()
        btn.setImage(UIImage(named: "ic_add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.setImageTintColor(.white, for: .normal)
        btn.setElevation(ShadowElevation(rawValue: 10), for: .normal)
        btn.layer.cornerRadius = 27.5
        btn.backgroundColor = .colorPrimary
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
        
        bind(to: viewModel)
    }
    
    func settingLayout(){
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = Translate.translate("pautas_fechadas")
        lblDescripiton.text = Translate.translate("pautas_fechadas_detalhes")
        
        view.addSubview(lblDescripiton)
        NSLayoutConstraint.activate([
            lblDescripiton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lblDescripiton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            lblDescripiton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lblDescripiton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        view.addSubview(btnAdicionarNovaPauta)
        NSLayoutConstraint.activate([
            btnAdicionarNovaPauta.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            btnAdicionarNovaPauta.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            btnAdicionarNovaPauta.heightAnchor.constraint(equalToConstant: 55),
            btnAdicionarNovaPauta.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        btnAdicionarNovaPauta.addTarget(self, action: #selector(irParaCadastroPauta), for: .touchUpInside)
    }
    
    private func bind(to viewModel: DefaultListaPautasViewModel){
        viewModel.pautasFechadas.observe(on: self) { _ in self.reloadData() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0)}
        viewModel.loadingType.observe(on: self) { [weak self] in self?.loadingState($0) }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: Constants.APP_NAME, message: error)
    }
    
    private func loadingState( _ state: ViewModelLoading){
        switch state {
        case .loading:
            
            break
        case .reloading:
            
            break
        case .finish:
            self.tableView.refreshControl?.endRefreshing()
            break
        default:
            
            break
        }
    }
    
    private func reloadData(){
        isOpened = Array(repeating: false, count: viewModel.pautasFechadas.value.count)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    private func selectedItem(position: Int){
        if isOpened[position] {
            isOpened[position] = false
        }else {
            isOpened = Array(repeating: false, count: viewModel.pautasFechadas.value.count)
            isOpened[position] = true
        }
        tableView.reloadData()
    }
    
    @objc func irParaCadastroPauta(){
        let cadastroPauta = CadastroPautaViewController()
        cadastroPauta.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cadastroPauta, animated: true)
    }
    
    @objc func selectedItemButton(sender: MDCCard){
        selectedItem(position: sender.tag)
    }
    
    @objc func selectedItemRecoginizer(sender: TapGesture){
        selectedItem(position: sender.tag)
    }
    
    @objc func atualizarListaPautasAbertas(_ sender: UIRefreshControl){
        viewModel.ataulizarListaPautas()
    }
    
    @objc func reabrirPauta(_ sender: MDCButton){
        viewModel.reabrirPauta(at: sender.tag)
    }
}

extension PautasFechadasViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pautasFechadas.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PautasViewCell.identifier, for: indexPath) as! PautasViewCell
        
        let tag: Int  = indexPath.row
        
        let item = viewModel.pautasFechadas.value[tag]
        let isOpen = isOpened[tag]
        
        cell.btnPauta.tag = tag
        cell.btnPauta.addTarget(self, action: #selector(reabrirPauta(_:)), for: .touchUpInside)
        
        cell.view.tag = tag
        cell.view.addTarget(self, action: #selector(selectedItemButton(sender:)), for: .touchUpInside)
        
        let gestureMinimumInfo = TapGesture(target: self, action: #selector(selectedItemRecoginizer(sender:)))
        gestureMinimumInfo.tag = tag
        cell.contentMinimumInfo.addGestureRecognizer(gestureMinimumInfo)
        
        let gestureExtraInfo = TapGesture(target: self, action: #selector(selectedItemRecoginizer(sender:)))
        gestureExtraInfo.tag = tag
        cell.contentExtraInfo.addGestureRecognizer(gestureExtraInfo)
        
        cell.configureCell(viewModel: item, isOpen)
        return cell
    }
}
