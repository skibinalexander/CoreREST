//
//  RequestBuilder.swift
//  RequestBuilder
//
//  Created by Скибин Александр on 06.10.2021.
//

import Alamofire
import SwiftyJSON
import Foundation

/// "Строитель" модели запроса
public final class RequestBuilder {
    
    /// Модель запроса
    public class Request: RequestModel {
        
        public var url: URL
        public var method: Alamofire.HTTPMethod
        public var headers: HTTPHeaders?
        public var parameters: Parameters?
        public var encoding: ParameterEncoding
        
        init(
            url: URL,
            method: Alamofire.HTTPMethod,
            headers: HTTPHeaders? = nil,
            parameters: Parameters? = nil,
            encoding: ParameterEncoding
        ) {
            self.url = url
            self.method = method
            self.headers = headers
            self.parameters = parameters
            self.encoding = encoding
        }
    }
    
    // MARK: - Properties
    
    public var url: URLConvertible
    public var headers: HTTPHeaders?
    public var parameters: Parameters?
    public var encoding: ParameterEncoding
    
    // MARK: - Init
    
    public init(
        url: String,
        headers: HTTPHeaders? = nil,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding
    ) {
        self.url = try! url.asURL()
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
    
    // MARK: - Implementation
    
    public func get() -> Request {
        Request(
            url: try! url.asURL(),
            method: .get,
            headers: headers,
            parameters: parameters,
            encoding: encoding
        )
    }
    
    public func post() -> Request {
        Request(
            url: try! url.asURL(),
            method: .post,
            headers: headers,
            parameters: parameters,
            encoding: encoding
        )
    }
    
    public func put() -> Request {
        Request(
            url: try! url.asURL(),
            method: .put,
            headers: headers,
            parameters: parameters,
            encoding: encoding
        )
    }
    
    public func patch() -> Request {
        Request(
            url: try! url.asURL(),
            method: .patch,
            headers: headers,
            parameters: parameters,
            encoding: encoding
        )
    }
    
    public func delete() -> Request {
        Request(
            url: try! url.asURL(),
            method: .delete,
            headers: headers,
            parameters: parameters,
            encoding: encoding
        )
    }
    
}
