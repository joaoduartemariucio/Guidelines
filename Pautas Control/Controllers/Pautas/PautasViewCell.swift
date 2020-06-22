//
//  PautasViewCell.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialButtons_Theming

class PautasViewCell: UITableViewCell {
    
    static let identifier = String(describing: PautasViewCell.self)
    
    private var viewModel: PautaItemViewModel!
    
    var view: MDCCard = {
        var view = MDCCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius = 10
        view.setShadowElevation(ShadowElevation(rawValue: 3), for: .normal)
        return view
    }()
    
    var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var contentMinimumInfo: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var titulo: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(0.2))
        label.textColor = .darkText
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var breveDescricao: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(0.1))
        label.textColor = .gray
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var contentExtraInfo: UIView = {
        var view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var detalhes: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(0.1))
        label.textColor = .gray
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var autor: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(0.1))
        label.textColor = .darkText
        label.numberOfLines = 0
        label.fitTextToBounds()
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var btnPauta: MDCButton = {
        var btn = MDCButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        settingLayoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func settingLayoutCell(){
        contentView.backgroundColor = .clear
        
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        stackView.addArrangedSubview(contentMinimumInfo)
        
        contentMinimumInfo.addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.topAnchor.constraint(equalTo: contentMinimumInfo.topAnchor),
            titulo.leadingAnchor.constraint(equalTo: contentMinimumInfo.leadingAnchor),
            titulo.trailingAnchor.constraint(equalTo: contentMinimumInfo.trailingAnchor)
        ])
        
        contentMinimumInfo.addSubview(breveDescricao)
        NSLayoutConstraint.activate([
            breveDescricao.topAnchor.constraint(equalTo: titulo.bottomAnchor, constant: 10),
            breveDescricao.leadingAnchor.constraint(equalTo: contentMinimumInfo.leadingAnchor),
            breveDescricao.trailingAnchor.constraint(equalTo: contentMinimumInfo.trailingAnchor),
            breveDescricao.bottomAnchor.constraint(equalTo: contentMinimumInfo.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(contentExtraInfo)
        
        contentExtraInfo.addSubview(detalhes)
        NSLayoutConstraint.activate([
            detalhes.topAnchor.constraint(equalTo: contentExtraInfo.topAnchor, constant: 10),
            detalhes.leadingAnchor.constraint(equalTo: contentExtraInfo.leadingAnchor),
            detalhes.trailingAnchor.constraint(equalTo: contentExtraInfo.trailingAnchor),
        ])
        
        contentExtraInfo.addSubview(autor)
        NSLayoutConstraint.activate([
            autor.topAnchor.constraint(equalTo: detalhes.bottomAnchor, constant: 10),
            autor.leadingAnchor.constraint(equalTo: contentExtraInfo.leadingAnchor),
            autor.trailingAnchor.constraint(equalTo: contentExtraInfo.trailingAnchor)
        ])
        
        contentExtraInfo.addSubview(btnPauta)
        NSLayoutConstraint.activate([
            btnPauta.topAnchor.constraint(equalTo: autor.bottomAnchor, constant: 10),
            btnPauta.trailingAnchor.constraint(equalTo: contentExtraInfo.trailingAnchor),
            btnPauta.widthAnchor.constraint(equalToConstant: 150),
            btnPauta.heightAnchor.constraint(equalToConstant: 40),
            btnPauta.bottomAnchor.constraint(equalTo: contentExtraInfo.bottomAnchor)
        ])
        
        btnPauta.applyOutlinedTheme(withScheme: MDCContainerScheme())
    }
    
    func configureCell(viewModel: PautaItemViewModel,_ isOpen: Bool = false){
        
        self.viewModel = viewModel
        
        titulo.text = viewModel.titulo
        breveDescricao.text = viewModel.breveDescricao
        detalhes.text = viewModel.detalhes
        autor.text = "\(Translate.translate("autor")): \(viewModel.autor)"
        
        if viewModel.finalizada {
            
            btnPauta.setTitle(Translate.translate("reabrir"), for: .normal)
            btnPauta.setBorderColor(.verde, for: .normal)
            btnPauta.setTitleColor(.verde, for: .normal)
            btnPauta.setImage(UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnPauta.setImageTintColor(.verde, for: .normal)
            btnPauta.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        }else {
            
            btnPauta.setTitle(Translate.translate("finalizar"), for: .normal)
            btnPauta.setBorderColor(.red, for: .normal)
            btnPauta.setTitleColor(.red, for: .normal)
            btnPauta.setImage(UIImage(named: "correct")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnPauta.setImageTintColor(.red, for: .normal)
            btnPauta.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
        }
        
        if isOpen {
            self.contentExtraInfo.isHidden = false
        }else {
            self.contentExtraInfo.isHidden = true
        }
    }
}
