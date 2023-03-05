//
//  RESTAdapterResponseProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 06.05.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import SwiftyJSON

/// Базовый интерфейс отвеса сервера
public protocol ResponseModel: Decodable {
    
    /// Инициализатор
    /// - Parameter json: Data JSON object
    static func map(json: JSON) -> Self
    
}
