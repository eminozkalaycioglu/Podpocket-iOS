
import Foundation
import Moya

typealias APIResult<T> = Result<T,MoyaError>

public final class ServiceManager {
    
    fileprivate let provider = MoyaProvider<ListenAPI>(plugins: [NetworkLoggerPlugin()])
    
    fileprivate var jsonDecoder = JSONDecoder()

    public static let shared = ServiceManager()

    fileprivate func fetch<M: Decodable>(target: ListenAPI,
                                         completion: @escaping (_ result: APIResult<M>) -> Void ) {

        provider.request(target) { (result) in

            switch result {
            case .success(let response):

                do {

                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let mappedResponse = try filteredResponse.map(M.self,
                                                                  atKeyPath: nil,
                                                                  using: self.jsonDecoder,
                                                                  failsOnEmptyData: false)
                    let urlResponse = response.response as! HTTPURLResponse
                    let usage = urlResponse.allHeaderFields["x-listenapi-usage"]
                    print("WWWW \(usage)")
                    completion(.success(mappedResponse))
                } catch MoyaError.statusCode(let response) {
                    if response.statusCode == 401 {

                    }
                    completion(.failure(MoyaError.statusCode(response)))
                } catch {
                    debugPrint("##ERROR parsing##: \(error.localizedDescription)")
                    let moyaError = MoyaError.requestMapping(error.localizedDescription)
                    completion(.failure(moyaError))
                }
            case .failure(let error):
                debugPrint("##ERROR service:## \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    

    func fetchBestPodcastsInSpecificRegion(region: String,completion: @escaping (_ result: APIResult<PodcastModel>) -> Void) {
        fetch(target: .fetchBestPodcastsInSpecificRegion(region: region), completion: completion)
    }
    
    func fetchPodcastDetail(id: String, pubDate: Int?, completion: @escaping (_ result: APIResult<Podcast>) -> Void) {
        fetch(target: .fetchPodcastDetail(id: id, nextEpisodePudDate: pubDate), completion: completion)
    }
    
    func fetchSimilarPodcasts(id: String, completion: @escaping (_ result: APIResult<SimilarPodcasts>) -> Void) {
        fetch(target: .fetchSimilarPodcasts(id: id), completion: completion)
        
    }
    
    func search(query: String, type: SearchType, offset: Int, genres: [String]? = nil, completion: @escaping (_ result: APIResult<SearchModel>) -> Void) {

        fetch(target: .search(query: query, type: type, offset: offset, genres: genres), completion: completion)
        
        
    }
    
    func fetchGenres(completion: @escaping (_ result: APIResult<Genres>) -> Void) {
        fetch(target: .fetchGenres, completion: completion)
    }
    

}





