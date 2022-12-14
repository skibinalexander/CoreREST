//
//  RESTAdapterRequestProtocol.swift
//  Parcel
//
//  Created by Skibin Alexander on 06.05.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Alamofire
import Foundation

/// Базовый интерфейс запроса
public protocol RequestModel {
    
    /// Адрес обращения запроса
    var url: URL { get set }
    
    /// Тип запроса по REST
    var method: Alamofire.HTTPMethod { get set }
    
    /// Заголовок обращения
    var headers: HTTPHeaders? { get set }
    
    /// Параметры запроса
    var parameters: Parameters? { get set }
    
    /// Способ отправки параметров запроса
    var encoding: ParameterEncoding { get set }
    
}
