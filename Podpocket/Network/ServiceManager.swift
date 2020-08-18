
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
    

}



