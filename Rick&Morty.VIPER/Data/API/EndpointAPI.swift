//
//  EndpointAPI.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation
import Alamofire

enum EndpointAPI {
   case getCharacters
}

extension EndpointAPI : BaseAPI {
    var host: String {
        Constants.Api.host
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "character"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .getCharacters:
            return [:]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .get
        }
    }
    
    var task: EndpointTask {
        switch self {
        case .getCharacters:
            return .requestPlain
        }
    }
}
