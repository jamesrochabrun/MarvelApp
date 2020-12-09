//
//  Marvel.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation

enum MarvelFeed {
    case characters
}

extension MarvelFeed: Endpoint {
    
    var formattedTimeStamp: String { return UUID().uuidString }

    var queryItems: [URLQueryItem] {
        switch self {
        case .characters:
            let tsQueryitem = URLQueryItem(name: "ts", value: formattedTimeStamp)
            let apiKey = URLQueryItem(name: "apikey", value: Self.publicKey)
            let hash = "\(formattedTimeStamp)\(Self.privateKey)\(Self.publicKey)".md5
            let hashQuery = URLQueryItem(name: "hash", value: hash)
            return [tsQueryitem, apiKey, hashQuery]
        }
    }
    
    
    static var privateKey = "6905a8e2fb2033fdb10eea66645116669f1c4f04"
    static var publicKey = "27d25dbafd3ff80a9d448a19c11ace4d"
    
    var base: String { "https://gateway.marvel.com:443/v1/public/" }
    
    var path: String {
        switch self {
        case .characters: return "characters"
        }
    }
}
