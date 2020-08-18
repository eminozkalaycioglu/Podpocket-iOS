//
//  PodcastModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 18, 2020

import Foundation

//MARK: - PodcastModel
struct PodcastModel: Decodable, Hashable {
    
    var hasNext : Bool?
    var hasPrevious : Bool?
    var id : Int?
    var listennotesUrl : String?
    var name : String?
    var nextPageNumber : Int?
    var pageNumber : Int?
    var parentId : Int?
    var podcasts : [Podcast]?
    var previousPageNumber : Int?
    var total : Int?
    
    enum CodingKeys : String, CodingKey {
        case hasNext = "has_next"
        case hasPrevious = "has_previous"
        case id = "id"
        case listennotesUrl = "listennotes_url"
        case name = "name"
        case nextPageNumber = "next_page_number"
        case pageNumber = "page_number"
        case parentId = "parent_id"
        case podcasts = "podcasts"
        case previousPageNumber = "previous_page_number"
        case total = "total"
        
        
    }
    
}
