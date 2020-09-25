//
//  SearchPodcastResult.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 27, 2020

import Foundation

//MARK: - SearchPodcastResult
struct SearchResult: Decodable, Hashable {
    
    var id : String?
    var image : String?
    var audio: String?
    var descriptionOriginal: String?
    var titleOriginal : String?
    var pubDateMs: Int?
    var podcast: ParentPodcast2?
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case image = "image"
        case titleOriginal = "title_original"
        case pubDateMs = "pub_date_ms"
        case podcast = "podcast"
        case audio = "audio"
        case descriptionOriginal = "description_original"
       
    }
        
}

struct ParentPodcast2: Decodable, Hashable {
    var id: String?
    var titleOriginal: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case titleOriginal = "title_original"
    }
    
}


