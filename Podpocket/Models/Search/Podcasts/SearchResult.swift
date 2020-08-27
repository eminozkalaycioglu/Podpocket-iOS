//
//  SearchPodcastResult.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 27, 2020

import Foundation

//MARK: - SearchPodcastResult
struct SearchResult: Decodable {

    var id : String?
    var image : String?
    var titleOriginal : String?

    enum CodingKeys : String, CodingKey {
        case id = "id"
        case image = "image"
        case titleOriginal = "title_original"
       
    }
        
}
