//
//  Observable.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 23/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

public final class Observable<Value> {
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    public var value: Value {
        didSet { notifyObservers() }
    }
    
    public init( _ value: Value){
        self.value = value
    }
    
    public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void){
        observers.append(Observer(observer: observer, block: observerBlock))
        DispatchQueue.main.async { observerBlock(self.value) }
    }
    
    public func remove(observer: AnyObject){
        observers = observers.filter { $0.observer !== observer }
    }
    
    private func notifyObservers(){
        for observer in observers {
            DispatchQueue.main.async {
                observer.block(self.value)
            }
        }
    }
}
