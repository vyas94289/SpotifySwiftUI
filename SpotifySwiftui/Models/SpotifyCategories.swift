// Generated with quicktype
// For more options, try https://app.quicktype.io

import Foundation

struct SpotifyCategoriesModel: Codable {
    let error: SpotifyError?
    let categories: Categories?
    
    struct Categories: Codable {
        let href: String?
        let items: [Item]
        let limit: Int
        let next: String?
        let offset: Int
        let previous: String?
        let total: Int
    }
    struct Item: Codable, Identifiable {
        let href: String
        let icons: [SpotifyIcon]
        let id, name: String
    }
}

struct SpotifyIcon: Codable, Identifiable {
    let id = UUID()
    let height: Int?
    let url: String
    let width: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decode(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }
}


