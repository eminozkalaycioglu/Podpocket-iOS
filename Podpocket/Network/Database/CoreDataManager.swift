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
    
    
    
    func getLastListenedPodcasts(completion: (([LastListenedPodcasts])->())) {
        
        var podcasts = [LastListenedPodcasts]()
        
        let request: NSFetchRequest<LastListenedPodcasts> = LastListenedPodcasts.fetchRequest()
        
        do {
            podcasts = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        completion(podcasts.reversed())
    }
    
    func getLastListenedEpisodes(completion: (([LastListenedEpisodes])->())) {
        
        var episodes = [LastListenedEpisodes]()
        
        let request: NSFetchRequest<LastListenedEpisodes> = LastListenedEpisodes.fetchRequest()
        
        do {
            episodes = try self.moc.fetch(request)
        } catch let error as NSError {
            print(error)
        }
        completion(episodes.reversed())
        
    }
    
    func savePodcast(podcastId: String, podcastImage: String, podcastTitle: String) {
        
        self.getLastListenedPodcasts { (podcasts) in
            for pod in podcasts {
                if podcastId == pod.podcastId {
                    self.moc.delete(pod)
                }
            }
        }
        
        let podcast = LastListenedPodcasts(context: self.moc)
        podcast.podcastId = podcastId
        podcast.podcastImage = podcastImage
        podcast.podcastTitle = podcastTitle
        
        
        
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func saveEpisode(episodeId: String, episodeImage: String, episodeTitle: String) {
        
        self.getLastListenedEpisodes { (episodes) in
            for episode in episodes {
                if episode.episodeId == episodeId {
                    self.moc.delete(episode)
                }
            }
        }
        let episode = LastListenedEpisodes(context: self.moc)
        episode.episodeId = episodeId
        episode.episodeImage = episodeImage
        episode.episodeTitle = episodeTitle
        do {
            try self.moc.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func deleteAllRecords() {
        

        let deletePodcastFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "LastListenedPodcasts")
        let deletePodcastRequest = NSBatchDeleteRequest(fetchRequest: deletePodcastFetch)
        
        let deleteEpisodeFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "LastListenedEpisodes")
        let deleteEpisodeRequest = NSBatchDeleteRequest(fetchRequest: deleteEpisodeFetch)

        do {
            try self.moc.execute(deletePodcastRequest)
            try self.moc.execute(deleteEpisodeRequest)

            try self.moc.save()
        } catch {
            print ("There was an error (Delete)")
        }
    }
    
}

