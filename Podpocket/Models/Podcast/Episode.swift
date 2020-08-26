//
//  Episode.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 20, 2020

import Foundation

//MARK: - Episode
struct Episode: Decodable, Hashable {
    
    var audio : String?
    var audioLengthSec : Int?
    var descriptionField : String?
    var explicitContent : Bool?
    var id : String?
    var image : String?
    var link : String?
    var listennotesEditUrl : String?
    var listennotesUrl : String?
    var maybeAudioInvalid : Bool?
    var pubDateMs : Int?
    var thumbnail : String?
    var title : String?
    
    enum CodingKeys : String, CodingKey {
        case audio = "audio"
        case audioLengthSec = "audio_length_sec"
        case descriptionField = "description"
        case explicitContent = "explicit_content"
        case id = "id"
        case image = "image"
        case link = "link"
        case listennotesEditUrl = "listennotes_edit_url"
        case listennotesUrl = "listennotes_url"
        case maybeAudioInvalid = "maybe_audio_invalid"
        case pubDateMs = "pub_date_ms"
        case thumbnail = "thumbnail"
        case title = "title"

        
        
    }
    
}
