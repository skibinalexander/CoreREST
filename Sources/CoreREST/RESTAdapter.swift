//
//  RESTAdapter.swift
//  Parcel
//
//  Created by Skibin Alexander on 06.05.2020.
//  Copyright © 2020 Skibin Development. All rights reserved.
//

import Foundation

#if !os(macOS)

import Alamofire
import SwiftyJSON

public typealias Validate = (_ request: URLRequest?, _ response: HTTPURLResponse, _ data: Data?) -> Result<Void, Error>
public typealias Status = ((Int?) -> Void)?
public typealias CompletionVoid = ((Result<Void, AFError>) -> Void)?
public typealias CompletionOptionalData = ((Result<Data?, AFError>) -> Void)?
public typealias CompletionData = ((Result<Data, AFError>) -> Void)?

public final class RESTAdapter {
    
    // MARK: - Properties
    
    /// Singletone
    public static let shared: RESTAdapter = RESTAdapter()
    
    /// Текущая сессия
    private var session: Alamofire.Session
    
    // MARK: - Lifecycle
    
    public init() {
        session = Alamofire.Session.default
    }
    
    public init(session: Alamofire.Session) {
        self.session = session
    }
    
    // MARK: - Public Implementation
    
    /// Обновить рабочую сессию адаптера
    /// - Parameter session: Обновлённая сессия адаптера
    public func update(session: Alamofire.Session) {
        self.session = session
    }
    
    /// Метод для выполнения всех запросов
    ///
    /// - Parameter request: Модель запроса
    /// - Parameter interceptor: Интерцептор запроса, для разделения логики перед отправкой запроса
    /// - Parameter success: Получение успешного выполнения запроса после выполнения валидаций
    /// - Parameter failure: Получение запроса с ошибкой после выполнения валидаций
    /// - Parameter result: Completion result работы запроса
    public func executeData<Request>(
        request: Request,
        interceptor: RequestInterceptor? = nil,
        validator: @escaping Validate,
        status: Status = nil,
        completion: CompletionData = nil
    ) where Request: RequestModel {
        session
            .request(
                request.url,
                method: request.method,
                parameters: request.parameters,
                encoding: request.encoding,
                headers: request.headers,
                interceptor: interceptor
            )
            .validate(validator)
            .responseData { responseData in
                status?(responseData.response?.statusCode)
                completion?(responseData.result)
            }
    }
    
    public func executeOptionalData<Request>(
        request: Request,
        interceptor: RequestInterceptor? = nil,
        validator: @escaping Validate,
        status: Status = nil,
        completion: CompletionOptionalData = nil
    ) where Request: RequestModel {
        session
            .request(
                request.url,
                method: request.method,
                parameters: request.parameters,
                encoding: request.encoding,
                headers: request.headers,
                interceptor: interceptor
            )
            .validate(validator)
            .response { responseData in
                status?(responseData.response?.statusCode)
                completion?(responseData.result)
            }
    }
    
    public func executeVoid<Request>(
        request: Request,
        interceptor: RequestInterceptor? = nil,
        validator: @escaping Validate,
        status: Status = nil,
        completion: CompletionVoid = nil
    ) where Request: RequestModel {
        session
            .request(
                request.url,
                method: request.method,
                parameters: request.parameters,
                encoding: request.encoding,
                headers: request.headers,
                interceptor: interceptor
            )
            .validate(validator)
            .response { responseData in
                status?(responseData.response?.statusCode)
                completion?(.success(()))
            }
    }
    
    public func uploadFormData<Request, Response>(
        multipartFormData: MultipartFormData,
        request: Request,
        interceptor: RequestInterceptor? = nil,
        validator: @escaping Validate,
        status: Status = nil,
        progress: @escaping ((Progress) -> Void),
        result: ((Result<Response, Error>) -> Void)? = nil
    ) where Request: RequestModel, Response: ResponseModel {
        session
            .upload(
                multipartFormData: multipartFormData,
                to: request.url,
                method: request.method,
                headers: request.headers,
                interceptor: interceptor
            )
            .validate(validator)
            .uploadProgress(closure: progress)
            .responseData { responseData in
                status?(responseData.response?.statusCode)
                
                switch responseData.result {
                case .success(let data):
                    result?(.success(Response.map(json: JSON(data))))
                case .failure(let error):
                    result?(.failure(error))
                }
            }
    }
    
}

#endif
