//
//  Podcast.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 18, 2020

import Foundation

//MARK: - Podcast
struct Podcast: Decodable, Hashable {
    
    var country : String?
    var descriptionField : String?
    var earliestPubDateMs : Int?
    var email : String?
    var explicitContent : Bool?
    var extra : Extra?
    var genreIds : [Int]?
    var id : String?
    var image : String?
    var isClaimed : Bool?
    var itunesId : Int?
    var language : String?
    var latestPubDateMs : Int?
    var listennotesUrl : String?
    var lookingFor : LookingFor?
    var publisher : String?
    var rss : String?
    var thumbnail : String?
    var title : String?
    var totalEpisodes : Int?
    var type : String?
    var website : String?

    var episodes : [Episode]?
    var nextEpisodePubDate : Int?

    
    
    enum CodingKeys : String, CodingKey {
        case country = "country"
        case descriptionField = "description"
        case earliestPubDateMs = "earliest_pub_date_ms"
        case email = "email"
        case explicitContent = "explicit_content"
        case extra = "extra"
        case genreIds = "genre_ids"
        case id = "id"
        case image = "image"
        case isClaimed = "is_claimed"
        case itunesId = "itunes_id"
        case language = "language"
        case latestPubDateMs = "latest_pub_date_ms"
        case listennotesUrl = "listennotes_url"
        case lookingFor = "looking_for"
        case publisher = "publisher"
        case rss = "rss"
        case thumbnail = "thumbnail"
        case title = "title"
        case totalEpisodes = "total_episodes"
        case type = "type"
        case website = "website"
        case episodes = "episodes"
        case nextEpisodePubDate = "next_episode_pub_date"

        
        
    }
}
