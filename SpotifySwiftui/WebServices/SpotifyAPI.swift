//
//  SpotifyApis.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 12/06/21.
//
import Foundation
import Combine

enum SpotifyAPI {
    static let agent = Agent()
    static let base = URL(string: WsUrls.spotifyBase)!
    static let headers = WsHeaders.spotifyAll
    
    static func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func getRequest(path: String, params: [String: String]? = nil) -> URLRequest {
        var url: URL = base.appendingPathComponent(path)
        if let params = params {
            let queryItem = params.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            var urlComps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            urlComps.queryItems = queryItem
            url = urlComps.url!
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        return request
    }
}

extension SpotifyAPI {
        
    static func fetchCategories() -> AnyPublisher<SpotifyCategoriesModel, Error> {
        return run(getRequest(path: WsUrls.spotifyCategories))
    }
    
    static func fetchNewReleases(offset: Int, limit: Int) -> AnyPublisher<SpotifyNewReleaseModel, Error> {
        let params = ["offset": String(offset), "limit": String(limit), "country": "IN"]
        return run(getRequest(path: WsUrls.spotifyNewRelease, params: params))
    }
    
    static func fetchFeaturedPlaylist(offset: Int, limit: Int) -> AnyPublisher<SpotifyFeaturedPlaylist, Error> {
        let params = ["offset": String(offset), "limit": String(limit), "country": "IN"]
        return run(getRequest(path: WsUrls.spotifyFeaturedPlaylists, params: params))
    }
}
