
import Foundation
import Moya

enum ListenAPI {
    
    case fetchBestPodcastsInSpecificRegion(region: String)
    case fetchPodcastDetail(id: String, nextEpisodePudDate: String?)
    case fetchSimilarPodcasts(id: String)
    case search(query: String, type: SearchType, offset: Int, genres: [String]? = nil)
    case fetchGenres
}

enum SearchType {
    case Episode
    case Podcast
}


extension ListenAPI: TargetType {
    
    var apiKey: String {
        return "ca536f2026d140c0bd8b322a58f63d5b"

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
                return .requestParameters(
                    
                    parameters: [
                        "sort": "recent_first"
                        ] ,
                    encoding: URLEncoding.default)
            }
            
        case .fetchSimilarPodcasts(_):
            return .requestParameters(
                
                parameters: [
                    "safe_mode": "0"
                    ] ,
                encoding: URLEncoding.default)
            
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
            return .requestParameters(parameters: [String : Any](), encoding: URLEncoding.default)
        }
    }
}

