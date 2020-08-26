
import Foundation
import Moya

enum ListenAPI {
    
    case fetchBestPodcastsInSpecificRegion(region: String)
    case fetchPodcastDetail(id: String, nextEpisodePudDate: String?)
    case fetchSimilarPodcasts(id: String)
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
            
        }
    }
}

