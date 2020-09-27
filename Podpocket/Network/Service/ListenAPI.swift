
import Foundation
import Moya

enum ListenAPI {
    
    case fetchBestPodcastsInSpecificRegion(region: String)
    case fetchPodcastDetail(id: String, nextEpisodePudDate: Int?)
    case fetchEpisodeDetail(id: String)
    case fetchSimilarPodcasts(id: String)
    case fetchSimilarEpisodes(id: String)

    case search(query: String, type: SearchType, offset: Int, genres: [String]? = nil)
    case fetchGenres
}

enum SearchType {
    case Episode
    case Podcast
}


extension ListenAPI: TargetType {
    var withoutParameters: Task {
        return .requestParameters(parameters: [String : Any](), encoding: URLEncoding.default)
    }

    var apiKey: String {

        return "7472e676513a470382a63d40800f27c9" //z

    }
    
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json",
            "X-ListenAPI-Key": self.apiKey
        ]
    }

    public var baseURL: URL {
        
        return URL(string: "https://listen-api.listennotes.com/api/v2")!

    }

    public var path: String {
        switch self {
        case .fetchBestPodcastsInSpecificRegion( _):
            return "/best_podcasts"
        
        case .fetchPodcastDetail(let id, _):
            return "/podcasts/\(id)"
            
        case .fetchSimilarPodcasts(let id):
            return "/podcasts/\(id)/recommendations"

        case .search(_, _, _, _):
            return "/search"
        case .fetchGenres:
            return "/genres"
        case .fetchEpisodeDetail(let id):
            return "/episodes/\(id)"
        case .fetchSimilarEpisodes(let id):
            return "/episodes/\(id)/recommendations"
        }
    }

    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        
        switch self {
        
        case .fetchBestPodcastsInSpecificRegion(let region):
            return .requestParameters(
                parameters: [
                    "region": region
                    ] ,
                encoding: URLEncoding.default)
            
        case .fetchPodcastDetail(_ , let pubDate):
            if let pubDate = pubDate {
                return .requestParameters(
                    parameters: [
                        "next_episode_pub_date": pubDate
                        ] ,
                    encoding: URLEncoding.default)
            }
            else {
                return self.withoutParameters
            }
            
        case .fetchSimilarPodcasts:
            return self.withoutParameters
        case .fetchSimilarEpisodes:
            return self.withoutParameters
            
        case .search(query: let query, type: let type, offset: let offset, genres: let genres):
            
            var dictionary: [String: Any] = [:]
            
            switch type {
            case .Episode:
                dictionary["type"] = "episode"
            case .Podcast:
                dictionary["type"] = "podcast"
            }
            
            if let genres = genres {
                var genresForURL = ""
                for genre in genres {
                    if genre == genres.last {
                        genresForURL += genre
                    } else {
                        genresForURL += genre + ","
                    }
                    
                }
                dictionary["genre_ids"] = genresForURL
            }
            
            dictionary["q"] = query
            dictionary["offset"] = offset
            
            return .requestParameters(parameters: dictionary, encoding: URLEncoding.default)
            
            
            
        case .fetchGenres:
            return self.withoutParameters
        case .fetchEpisodeDetail:
            return self.withoutParameters
        
        }
    }
}

