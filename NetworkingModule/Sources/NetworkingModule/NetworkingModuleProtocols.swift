//
//  File.swift
//  
//
//  Created by Bárbara Souza on 14/02/21.
//

import Foundation

public protocol HttpRequestProtocol {
    func request<T: Decodable>(_ type: T.Type,
                               from endpoint: Endpoint,
                               completion: ((Result<T, Error>) -> Void)?)
    
    func request(from endpoint: Endpoint,
                 completion: ((Result<Data, Error>) -> Void)?)
}

public protocol Endpoint {
    var url: String { get }
    var method: RequestMethod { get }
    var body: Data? { get }
    var headers: [String: String] { get }
}

public protocol HttpClientProtocol {
    func request(_ endpoint: Endpoint,
                 completion: ((Result<Data, Error>) -> Void)?)

}

