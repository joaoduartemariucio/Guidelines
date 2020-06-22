//
//  ProtocolViewModel.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 17/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

protocol ViewModel {
    
    var brokenRules: [BrokenRule] { get set }
    var isValid: Bool { mutating get }
}
