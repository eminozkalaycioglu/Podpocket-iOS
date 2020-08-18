
import Foundation
import Moya

enum ListenAPI {
    
    case fetchBestPodcastsInSpecificRegion(region: String)
    
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
            
        }
    }
}

