//
//  ApiBuilder.swift
//  
//
//  Created by skibinalexander on 26.02.2023.
//

import Foundation

/// Реализация Api
public struct ApiBuilder<T: RawRepresentable> where T.RawValue == String {
    
    // MARK: - Private
    
    private var storedPath: String
    
    // MARK: - Public
    
    public var path: String {
        return storedPath.replacingOccurrences(of: "//", with: "/")
    }
    
    public init(paths: [T]) {
        self.storedPath = ""
        self.storedPath.append(paths.compactMap { $0.rawValue }.joined(separator: "/") + "/")
    }
    
}
