//
//  ServiceBase.swift
//  MarvelApp
//
//  Created by James Rochabrun on 1/7/21.
//

import Foundation
import UIKit

/*
  paging?
 func fetch<T: Decodable>(listOf representable: T.Type,
                          withURL url: URL?,
                          completionHandler: @escaping (Result<T, FetchError>) -> Void) {

     guard let url = url else {
         completionHandler(.failure(.invalidURL))
         return
     }
     
     if offset != 0 && offset == total {
         completionHandler(.failure(.limite))
         return
     }
     
     task = session.data(with: url) { data, response, error  in
         
         guard
             error == nil else {
             DispatchQueue.main.async {
                 completionHandler(.failure(.networkFailed))
             }
             return
         }
         
         guard
             let httpResponse = response as? HTTPURLResponse,
             httpResponse.statusCode == 200
         else {
             DispatchQueue.main.async {
                 completionHandler(.failure(.networkFailed))
             }
             return
         }
         
         guard let data = data else {
             completionHandler(.failure(.invalidData))
             return
         }
         
         let decoder = JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase

         guard let genericModel = try? decoder.decode(T.self, from: data) else {
             DispatchQueue.main.async {
                 completionHandler(.failure(.invalidJSON))
             }
             return
         }
         
//
//            guard let response = ServiceResponse(data) else {
//                DispatchQueue.main.async {
//                    completionHandler(.failure(.invalidJSON))
//                }
//                return
//            }

//            self.offset = response.offset + response.count
//            self.total = response.total
//
//            var resultList = [T]()
//            let decoder = JSONDecoder()
//            response.results.forEach {
//                guard let jsonData = try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted),
//                    let result = try? decoder.decode(T.self, from: jsonData) else { return }
//
//                resultList.append(result)
//            }

         DispatchQueue.main.async {
             completionHandler(.success(genericModel))
         }
     }
     task?.resume()
 }
*/

class MarvelService: GenericAPI {
    
    lazy var offset = 0
    lazy var total = 0
    var session: URLSession
    
    private func timestamp() -> String {
        String(format: "%.0f", NSDate().timeIntervalSince1970)
    }
    
    internal var parameters: String {
        let authentication = (timestamp() + Keys.privateKey + Keys.publicKey).md5
        return "?" + ServiceParameters.timestamp + "=" + timestamp() + "&"
            + ServiceParameters.apiKey + "=" + Keys.publicKey + "&"
            + ServiceParameters.hash + "=" + authentication
    }
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    public convenience init() {
        self.init(configuration: .default)
    }
    
    func getParameters() -> String {
         parameters
    }
    
    internal func url(withPath path: String) -> URL? {
         URL(string: Service.base + path
            + parameters + "&"
                    + ServiceParameters.offset + "=" + "\(offset)")
    }
    
    func fetch<T: DataProtocol>(_ data: T.Type, completion: @escaping (Result<[T.R.T], APIError>) -> Void) {
        
        guard let marvelResource = MarvelResources(T: data.R) else { fatalError("hey whats goin gon") }
        guard let url = url(withPath: marvelResource.rawValue) else { fatalError("no url") }
        let request = URLRequest(url: url)
        fetch(with: request) {
            $0 as? T
        } completion: {
            switch $0 {
            case .success(let data):
                completion(.success(data.data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}

protocol DataProtocol: Decodable {
    associatedtype R: Resource
    var data: R { get }
}

protocol Resource: Decodable {
    associatedtype T
    var offset: Int { get }
    var limit: Int { get }
    var count: Int { get }
    var total: Int { get }
    var results: [T] { get }
}

struct MarvelData<R: Resource>: DataProtocol {
    let data: R
}

struct Resources<T: Decodable>: Resource {
    
    let offset: Int
    let limit: Int
    let count: Int
    let total: Int
    var results: [T]
}

enum MarvelResources: String {
    case characters
    case series
    case comics
}

extension MarvelResources {
    
    init?(T: Decodable.Type) {
        switch T {
        case is Resources<Character>.Type: self = .characters
        case is Resources<Serie>.Type: self = .series
        case is Resources<Comic>.Type: self = .comics
        default: return nil
        }
    }
}

struct Keys {
    static let privateKey: String = MarvelFeed.privateKey
    static let publicKey: String = MarvelFeed.publicKey
}

struct Service {
    static let base: String = "https://gateway.marvel.com/v1/public/"
}

struct ServiceParameters {
    static let apiKey: String = "apikey"
    static let hash: String = "hash"
    static let timestamp: String = "ts"
    static let offset: String = "offset"
}

protocol GenericAPI {
    
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension GenericAPI {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed(description: error.debugDescription))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let genericModel = try decoder.decode(T.self, from: data)
                        completion(genericModel, nil)
                    } catch let error {
                        completion(nil, .jsonConversionFailure(description: error.localizedDescription))
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful(description: "status code = \(httpResponse.statusCode)"))
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
            
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
