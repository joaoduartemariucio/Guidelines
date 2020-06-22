
//
//  DecodeData.swift
//  Pautas Control
//
//  Created by João Vitor Duarte Mariucio on 24/05/20.
//  Copyright © 2020 João Vitor Duarte Mariucio. All rights reserved.
//

import Foundation

class DecodeData {
    
    class func decode<T: Decodable>(_ decodable: T.Type, data: Data?) -> T? {
        guard let decodableData = data else { return nil }
        let decode = JSONDecoder()
        do {
            return try decode.decode(T.self, from: decodableData)
        }catch {
            return nil
        }
    }
    
    class func array<T: Decodable>(_ decodable: T.Type, data: Data?) -> Array<T>? {
        guard let decodableData = data else { return nil }
        let decode = JSONDecoder()
        do {
            return try decode.decode([T].self, from: decodableData)
        }catch {
            return nil
        }
    }
}
