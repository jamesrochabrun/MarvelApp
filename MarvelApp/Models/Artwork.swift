//
//  Artwork.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation

struct Artwork: Decodable {
    let path: String?
    let imageExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case path,
        imageExtension = "extension"
    }
}
