//
//  File.swift
//  
//
//  Created by Bárbara Souza on 14/02/21.
//

import Foundation

public class HttpRequest: HttpRequestProtocol {
    
    public static var shared: HttpRequestProtocol = HttpRequest()
    private let http: HttpClientProtocol
    private var decoder: JSONDecoder

    public init(decoder: JSONDecoder = JSONDecoder(), http: HttpClientProtocol = HttpClient()) {
        self.http = http
        self.decoder = decoder
    }

    public func request<T: Decodable>(_ type: T.Type,
                               from endpoint: Endpoint,
                               completion: ((Result<T, Error>) -> Void)?) {

        http.request(endpoint) { dataResult in
            DispatchQueue.main.async {
                switch dataResult {
                case .failure(let error):
                    completion?(.failure(error))
                    
                case .success(let data):
                    do {
                        let decodedObject = try self.decoder.decode(type, from: data)
                        completion?(.success(decodedObject))
                    } catch {
                        completion?(.failure(APIError.decode))
                    }
                }
            }
        }
    }
    
    public func request(from endpoint: Endpoint,
                        completion: ((Result<Data, Error>) -> Void)?) {
        http.request(endpoint) { dataResult in
            DispatchQueue.main.async {
                switch dataResult {
                case .failure(let error):
                    completion?(.failure(error))
                case .success(let data):
                    completion?(.success(data))
                }
            }
        }
    }
}
