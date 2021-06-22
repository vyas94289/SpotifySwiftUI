// Generated with quicktype
// For more options, try https://app.quicktype.io

import Foundation

struct SpotifyNewReleaseModel: Codable {
    let error: SpotifyError?
    let albums: Albums?
    
    struct Albums: Codable {
        let href: String
        let items: [Item]
        let limit: Int
        let next: String?
        let offset: Int
        let previous: String?
        let total: Int
    }

    struct Item: Codable, Identifiable {
        let albumType: String
        let artists: [Artist]
        let availableMarkets: [String]
        let href, id: String
        let images: [SpotifyIcon]
        let name, releaseDate, releaseDatePrecision: String
        let totalTracks: Int
        let type, uri: String

        enum CodingKeys: String, CodingKey {
            case albumType = "album_type"
            case artists
            case availableMarkets = "available_markets"
            case href, id, images, name
            case releaseDate = "release_date"
            case releaseDatePrecision = "release_date_precision"
            case totalTracks = "total_tracks"
            case type, uri
        }
    }

    struct Artist: Codable {
        let href, id, name, type: String
        let uri: String
    }
}

