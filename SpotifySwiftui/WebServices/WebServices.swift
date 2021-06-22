//
//  WebServices.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 12/06/21.
//

import Combine
import SwiftUI

import Foundation
import Combine

struct Agent {
    let session = URLSession.shared
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
/*
class WebServices {
   
    static func categoriesRequest<T:Codable>() -> AnyPublisher<T,Error> {
        
        guard let url = URL(string: WsUrls.spotifyBase + WsUrls.spotifyCategories) else {
            return .fail(AppError.invalidUrl)
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = WsHeaders.spotifyAll
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func getRequest<T:Codable>(url: URL) -> AnyPublisher<T,Error> {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = WsHeaders.spotifyAll
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
*/

extension Publisher {

    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty()
            .eraseToAnyPublisher()
    }

    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }

    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
