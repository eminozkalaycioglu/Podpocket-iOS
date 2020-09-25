//
//  EpisodeDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 23, 2020

import Foundation

//MARK: - EpisodeDetail
struct EpisodeDetail: Decodable {

    var audio: String!
    var audioLength: Int!
    var audioLengthSec: Int!
    var descriptionField: String!
    var explicitContent: Bool!
    var id: String!
    var image: String!
    var link: String!
    var listennotesEditUrl: String!
    var listennotesUrl: String!
    var maybeAudioInvalid: Bool!
    var podcast: ParentPodcast!
    var pubDateMs: Int!
    var thumbnail: String!
    var title: String!
    
    enum CodingKeys : String, CodingKey {
        case audio = "audio"
        case audioLengthSec = "audio_length_sec"
        case audioLength = "audio_length"
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
        case podcast = "podcast"

        
    }
    
        
}

extension EpisodeDetail {
    func convertToEpisodeModel() -> Episode {
        
        let episode = Episode(audio: self.audio, audioLengthSec: self.audioLength, descriptionField: self.descriptionField, explicitContent: self.explicitContent, id: self.id, image: self.image, link: self.link, listennotesEditUrl: self.listennotesEditUrl, listennotesUrl: self.listennotesUrl, maybeAudioInvalid: self.maybeAudioInvalid, pubDateMs: self.pubDateMs, thumbnail: self.thumbnail, title: self.title)
        
        return episode
        
    }
    
}
