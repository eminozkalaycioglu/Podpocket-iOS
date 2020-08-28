//
//  Genres.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2020

import Foundation

//MARK: - Genres
struct Genres: Decodable, Hashable {

    var genres : [Genre]?
        
    enum CodingKeys : String, CodingKey {
        case genres = "genres"
        

    }
}
