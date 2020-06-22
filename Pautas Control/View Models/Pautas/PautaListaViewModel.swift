//
//  PautaListaViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 18/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

protocol PautaListaViewModelInput {
    
    func viewWillAppear()
    func ataulizarListaPautas()
    func finalizarPauta(at index: Int)
    func reabrirPauta(at index: Int)
}

protocol PautaListaViewModelOutput {
    
    var pautasAbertas: Observable<[PautaItemViewModel]> { get }
    var pautasFechadas: Observable<[PautaItemViewModel]> { get }
    var loadingType: Observable<ViewModelLoading> { get }
    var isEmptyAbertas: Bool { get }
    var isEmptyFechadas: Bool { get }
    var error: Observable<String> { get }
}

protocol PautaListaViewModel: PautaListaViewModelInput, PautaListaViewModelOutput { }

final class DefaultListaPautasViewModel: PautaListaViewModel {
    
    private var pautasLoadTask: Cancellable? { willSet { pautasLoadTask?.cancel() } }
    
    //    MARK: - OUTPUT
    var pautasAbertas: Observable<[PautaItemViewModel]> = Observable([])
    var pautasFechadas: Observable<[PautaItemViewModel]> = Observable([])
    var loadingType: Observable<ViewModelLoading> = Observable(.none)
    var isEmptyAbertas: Bool { return pautasAbertas.value.isEmpty }
    var isEmptyFechadas: Bool { return pautasFechadas.value.isEmpty }
    var error: Observable<String> = Observable("")
    
    //    MARK: - Init
    private func load(loadingType: ViewModelLoading){
        self.loadingType.value = loadingType
        
        AuthFirebase().userInfo(){ userInfos, error in
            self.pautasFechadas.value.removeAll()
            self.pautasAbertas.value.removeAll()
            userInfos?.pautas.flatMap {
                if $0.finalizada {
                    self.pautasFechadas.value.append(PautaItemViewModel(pauta: $0))
                }else {
                    self.pautasAbertas.value.append(PautaItemViewModel(pauta: $0))
                }
            }
        }
       
        self.loadingType.value = .finish
    }
}

extension DefaultListaPautasViewModel {
    
    func viewWillAppear() {
        load(loadingType: .loading)
    }
    
    func ataulizarListaPautas() {
        load(loadingType: .reloading)
    }
    
    func reabrirPauta(at index: Int){
        let pauta = self.pautasFechadas.value[index].pauta()
        AuthFirebase().editarPauta(pauta: pauta, finalizar: false){ sucesso in
            self.load(loadingType: .reloading)
        }
    }
    
    func finalizarPauta(at index: Int) {
        let pauta = self.pautasAbertas.value[index].pauta()
        AuthFirebase().editarPauta(pauta: pauta, finalizar: true){ sucesso in
            self.load(loadingType: .reloading)
        }
    }
}
