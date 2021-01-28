//
//  API.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import Foundation
import Alamofire

typealias Parameters = ([String:Any])
typealias ParseURLCompletion = (urlRequest: URLRequest,parameters: Parameters, encoding: ParameterEncoding)

class API : NSObject {
    
    private var endPoint : EndpointAPI!
    
    init(endPoint : EndpointAPI) {
        self.endPoint = endPoint
    }
    
    func request<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        let request = asURLRequest(with: endPoint)
        
        guard let url = request.urlRequest.url else {
            return completion(.failure(Error.self as! Error))
        }
        
        AF.request(url, method: endPoint.method, parameters: request.parameters, encoding: request.encoding, headers: endPoint.headers)
            .validate(statusCode: 200..<300)
            .response(queue: .main) { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: data!)
                        completion(.success(decoded))

                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                case .failure(let error):
                    guard let underlyingError = error.underlyingError else { return }
                    
                    if let urlError = underlyingError as? URLError {
                        if let code = RequestError.init(rawValue: urlError.code.rawValue) {
                            completion(.failure(code))
                        } else {
                            completion(.failure(urlError))
                        }
                    }
                    
                }
            }
    }
}

//--------------------------------------------------------
// MARK: Make URL
//--------------------------------------------------------

extension API {
    
    private func asURLRequest(with endPoint : BaseAPI) -> ParseURLCompletion {
        
        let reqParameters: Parameters
        let reqEncoding: ParameterEncoding
        
        let url: URL! = URL(string: endPoint.host + endPoint.path)
        
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)

        switch endPoint.task {
        case .requestPlain:
            reqParameters = [:]
            reqEncoding = URLEncoding.default
        case let .requestParameters(parameters, encoding):
            reqParameters = parameters
            reqEncoding = encoding
        }
        
        return ParseURLCompletion(urlRequest,reqParameters,reqEncoding)
    }
}

//--------------------------------------------------------
// MARK: Debug
//--------------------------------------------------------

extension API {
    
     private func debugResponse(request: URLRequest, data : Data? = nil, error: Error? = nil) {
         let title = (data != nil) ? "SUCCESS" : "FAILURE"
         debugPrint("------------------\(title)------------------")
         debugPrint("URL: ", request.urlRequest?.url?.absoluteString ?? "")
         debugPrint("HEADERS: ", request.urlRequest?.allHTTPHeaderFields ?? "")

         
         var result : Any {
             if data != nil {
                 print("RESULT:")
                 return convertDataWithCompletionHandler(data!) { (object, err) in
                     print(object!)
                 }
             } else {
                 return "ERROR: \(error!)"
             }
         }
         
         debugPrint(result)
     }
     
     
     // given raw JSON, return a usable Foundation object
     private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {

         var parsedResult: AnyObject! = nil
         do {
             parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
         } catch {
             let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
             completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
         }
         completionHandlerForConvertData(parsedResult, nil)
     }

}

