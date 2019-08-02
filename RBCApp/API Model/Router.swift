//
//  Router.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
enum HeaderField : String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
}

enum Router {
    
    case getRestaurantsList(term: String,location: String, limit: String, offset:String)
    case getRestaurantDetail(id:String)
    
    func urlRequest(baseUrl: URL) -> URLRequest? {
        var component = URLComponents()
        component.scheme = baseUrl.scheme
        component.host = baseUrl.host
        component.path = path
        component.queryItems = queryItems
        guard let url = component.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        //urlRequest.httpBody = getData
        urlRequest.allHTTPHeaderFields = httpHeaders
        return urlRequest
    }
    
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
    }
    
    var httpMethod: String {
        return HTTPMethod.get.rawValue
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getRestaurantsList(let term, let location, let limit, let offSet):
            return [URLQueryItem(name: "term", value: term),
                    URLQueryItem(name: "location", value: location),
                    URLQueryItem(name: "limit", value: limit),
                    URLQueryItem(name: "offset", value: offSet)]
        case .getRestaurantDetail:
            return nil
        }
    }
    
    var httpHeaders: [String: String] {
        var headers: [String: String] = [HeaderField.contentType.rawValue : "application/json"]
        headers.updateValue("Bearer \(APIService.shared.apiKey)", forKey: HeaderField.authorization.rawValue)
        return headers
    }
    
    var path: String {
        switch self {
        case .getRestaurantsList:
            return "/v3/businesses/search"
        case .getRestaurantDetail(let id ):
            return "/v3/businesses/" + id
      
        }
    }
}

