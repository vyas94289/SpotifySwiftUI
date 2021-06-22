// Generated with quicktype
// For more options, try https://app.quicktype.io

import Foundation

struct SpotifyFeaturedPlaylist: Codable {
    let error: SpotifyError?
    let playlists: Playlists?
    
    struct Playlists: Codable {
        let href: String
        let items: [Item]
        let limit: Int
        let next: String?
        let offset: Int
        let previous: String?
        let total: Int
        
    }
    
    struct Item: Codable, Identifiable {
        let collaborative: Bool
        let description: String
        let href, id: String
        let images: [SpotifyIcon]
        let name: String
        let owner: Owner
        let snapshotID: String
        let tracks: Tracks
        let type, uri: String

        enum CodingKeys: String, CodingKey {
            case collaborative, description
            case href, id, images, name, owner
            case snapshotID = "snapshot_id"
            case tracks, type, uri
        }
    }

    struct Owner: Codable {
        let displayName: String
        let href, id, type, uri: String

        enum CodingKeys: String, CodingKey {
            case displayName = "display_name"
            case href, id, type, uri
        }
    }

    struct Tracks: Codable {
        let href: String
        let total: Int
    }

}
