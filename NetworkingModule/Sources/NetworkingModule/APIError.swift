//
//  File.swift
//  
//
//  Created by Bárbara Souza on 14/02/21.
//

import Foundation

public enum APIError: Error, Equatable {
    case jsonConversionFailure
    case invalidData
    case timeout
    case unauthorized
    case service
    case request
    case decode
    
    var localizedDescription: String {
        switch self {
        case .timeout:
            return "Connection error."
        case .unauthorized:
            return "Unauthorized."
        case .service, .request:
            return "Could not connect to the server."
        case .decode, .jsonConversionFailure, .invalidData:
            return "Could not display results."
        }
    }
}
