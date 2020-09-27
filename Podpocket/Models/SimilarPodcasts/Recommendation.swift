//
//  Recommendation.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 26, 2020

import Foundation

//MARK: - Recommendation
struct Recommendation: Decodable, Hashable {
    
    var id : String?
    var image : String?
    var title : String?
    var totalEpisodes: Int?
    
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case image = "image"
        case title = "title"
        case totalEpisodes = "total_episodes"
        
    }
}
