//
//  SearchPodcastModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 27, 2020

import Foundation

//MARK: - SearchPodcastModel
struct SearchModel: Decodable, Hashable {

    var count : Int?
    var nextOffset : Int?
    var results : [SearchResult]?
    var took : Float?
    var total : Int?
    
    enum CodingKeys : String, CodingKey {
        case count = "count"
        case nextOffset = "next_offset"
        case results = "results"
        case took = "took"
        case total = "total"

    }
        
}
