//
//  Extra.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 18, 2020

import Foundation

//MARK: - Extra
struct Extra: Decodable, Hashable {
    
    var facebookHandle : String?
    var googleUrl : String?
    var instagramHandle : String?
    var linkedinUrl : String?
    var patreonHandle : String?
    var spotifyUrl : String?
    var twitterHandle : String?
    var url1 : String?
    var url2 : String?
    var url3 : String?
    var wechatHandle : String?
    var youtubeUrl : String?
    
    enum CodingKeys : String, CodingKey {
        case facebookHandle = "facebook_handle"
        case googleUrl = "google_url"
        case instagramHandle = "instagram_handle"
        case linkedinUrl = "linkedin_url"
        case patreonHandle = "patreon_handle"
        case spotifyUrl = "spotify_url"
        case twitterHandle = "twitter_handle"
        case url1 = "url1"
        case url3 = "url3"
        case url2 = "url2"
        case wechatHandle = "wechat_handle"
        case youtubeUrl = "youtube_url"
        
        
        
    }
    
    
    
}
