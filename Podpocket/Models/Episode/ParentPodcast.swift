//
//  ParentPodcast.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 23, 2020

import Foundation

//MARK: - ParentPodcast
struct ParentPodcast: Decodable, Hashable {

    var country: String?
    var descriptionField: String?
    var earliestPubDateMs: Int?
    var email: String?
    var explicitContent: Bool?
    var genreIds: [Int]?
    var genres: [String]?
    var id: String?
    var image: String?
    var isClaimed: Bool?
    var itunesId: Int?
    var language: String?
    var lastestPubDateMs: Int?
    var latestPubDateMs: Int?
    var listennotesUrl: String?
    var publisher: String?
    var rss: String?
    var thumbnail: String?
    var title: String?
    var totalEpisodes: Int?
    var type: String?
    var website: String?
    
    
    enum CodingKeys : String, CodingKey {
        case country = "country"
        case descriptionField = "description"
        case earliestPubDateMs = "earliest_pub_date_ms"
        case email = "email"
        case explicitContent = "explicit_content"
        case genreIds = "genre_ids"
        case genres = "genres"
        case id = "id"
        case image = "image"
        case isClaimed = "is_claimed"
        case itunesId = "itunes_id"
        case language = "language"
        case lastestPubDateMs = "lastest_pub_date_ms"
        case latestPubDateMs = "latest_pub_date_ms"
        case listennotesUrl = "listennotes_url"
        case publisher = "publisher"
        case rss = "rss"
        case thumbnail = "thumbnail"
        case title = "title"
        case totalEpisodes = "total_episodes"
        case type = "type"
        case website = "website"
        

        
        
    }
        
}
