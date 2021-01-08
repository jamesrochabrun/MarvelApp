//
//  Endpoint.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation

protocol Endpoint  {
    var base:  String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }

}

extension Endpoint {
    
    /// http://gateway.marvel.com/v1/public/comics?ts=415CED7F-6AC3-411D-85A9-3712AEB06268&apikey=27d25dbafd3ff80a9d448a19c11ace4d&hash=d582e82cb0e6bc701d38366a0481621e
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
       // let url = urlComponents.url! //want to crash if no information is complete
        let url = URL(string: "http://gateway.marvel.com/v1/public/characters?ts=415CED7F-6AC3-411D-85A9-3712AEB06268&apikey=27d25dbafd3ff80a9d448a19c11ace4d&hash=d582e82cb0e6bc701d38366a0481621e")
        return URLRequest(url: url!)
    }
}
