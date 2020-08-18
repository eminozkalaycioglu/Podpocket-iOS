//
//  LookingFor.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 18, 2020

import Foundation

//MARK: - LookingFor
struct LookingFor: Decodable, Hashable {
    
    var cohosts : Bool?
    var crossPromotion : Bool?
    var guests : Bool?
    var sponsors : Bool?
    
    enum CodingKeys : String, CodingKey {
        case cohosts = "cohosts"
        case crossPromotion = "cross_promotion"
        case guests = "guests"
        case sponsors = "sponsors"
        
        
    }
    
}
