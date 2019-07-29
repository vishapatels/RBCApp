//
//  APIService.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

enum ServerError: Error {
    
    case invalidData
    case invalidURL
    case invalidResponse
    case networkError
    case apiError(eyesError: RBCError?)
}

enum ServiceResult<T> {
    case success(T)
    case failure(ServerError?)
}

struct RBCError: CoreServiceCodable {
    var statusCode: Int?
    var error: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case error
    }
}


class APIService: NSObject {
    private var logger: NetworkLogger = NetworkLogger()
    static let shared = APIService()
    // Should be done in config or info.plist.
    var baseURL = "https://api.yelp.com"
    var apiKey = "d4LyGaSsUtW6QUtUDxLn1pu9rv4ZQSkN6K3QFEc9moJh14sxiS4yjKSuqjjvD6O9mg99tW7cCtBHpd0pf5sHlHo-O9_1NkGzSFxa2OeF2Ngdkr_NuC0i6VtcXlo7XXYx"
    func performRequest(router: Router, completionHandler complete: @escaping (ServiceResult<Data?>) -> Void) {
        guard let urlRequest = router.urlRequest(baseUrl: URL(string: baseURL)!) else {
            complete(.failure(ServerError.invalidURL))
            return
        }
        logger.log(request: urlRequest)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if error == nil {
                if let urlResponse = response as? HTTPURLResponse {
                    self?.logger.log(response: urlResponse, data: data)
                    if urlResponse.isSuccess {
                        complete(.success(data))
                    } else {
                        if let data = data {
                            let commonError: RBCError? = RBCError.from(data: data)
                            complete(.failure(ServerError.apiError(eyesError: commonError)))
                        } else {
                            complete(.failure(ServerError.invalidResponse))
                        }
                    }
                }
            }
            }.resume()
    }
}

extension HTTPURLResponse {
    
    var isSuccess: Bool {
        return 200 ... 299 ~= statusCode
    }
}

