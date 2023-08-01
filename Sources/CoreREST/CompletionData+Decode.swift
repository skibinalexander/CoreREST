//
//  CompletionData+Decode.swift
//  
//
//  Created by skibinalexander on 15.02.2023.
//

import Foundation
import SwiftyJSON

extension Data {
    
    public func decode<D: Decodable>(_ type: D.Type) throws -> D {
        try JSONDecoder().decode(D.self, from: self)
    }
    
    public func decode<D: Decodable>(_ type: D.Type, with decoder: JSONDecoder) throws -> D {
        try decoder.decode(D.self, from: self)
    }
    
    public func decode<M: ResponseModel>(_ type: M.Type) throws -> M {
        M.map(json: JSON(self))
    }
    
}
