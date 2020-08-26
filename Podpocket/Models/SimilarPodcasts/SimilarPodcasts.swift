//
//  SimilarPodcasts.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 26, 2020

import Foundation

//MARK: - SimilarPodcasts
struct SimilarPodcasts: Decodable, Hashable {
    
    var recommendations : [Recommendation]?
    
    enum CodingKeys : String, CodingKey {
        case recommendations = "recommendations"
    }
    
}
