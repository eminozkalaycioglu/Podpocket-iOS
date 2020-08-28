//
//  Genre.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2020

import Foundation

//MARK: - Genre
struct Genre: Decodable, Hashable {

    var id : Int?
    var name : String?
    var parentId : Int?
    var selected: Bool?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case parentId = "parent_id"
        

    }
        
}
