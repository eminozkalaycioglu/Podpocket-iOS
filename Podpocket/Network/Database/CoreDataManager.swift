//
//  CoreDataManager.swift
//  Podpocket
//
//  Created by Emin on 24.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    
    
    func getLastListenedPodcasts() -> [LastListenedPodcasts] {
        
        var podcasts = [LastListenedPodcasts]()
        
        let request: NSFetchRequest<LastListenedPodcasts> = LastListenedPodcasts.fetchRequest()
        
        do {
            podcasts = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        return podcasts
        
    }
    
    func getLastListenedEpisodes(completion: (([LastListenedEpisodes])->())) {
        
        var episodes = [LastListenedEpisodes]()
        
        let request: NSFetchRequest<LastListenedEpisodes> = LastListenedEpisodes.fetchRequest()
        
        do {
            episodes = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        completion(episodes)
        
    }
    
    func savePodcast(podcastId: String, podcastImage: String) {
        
        let podcast = LastListenedPodcasts(context: self.moc)
        podcast.podcastId = podcastId
        podcast.podcastImage = podcastImage
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func saveEpisode(episodeId: String, episodeImage: String) {
        
        let episode = LastListenedEpisodes(context: self.moc)
        episode.episodeId = episodeId
        episode.episodeImage = episodeImage
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
}

