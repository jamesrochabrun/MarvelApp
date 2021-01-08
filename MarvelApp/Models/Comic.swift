//
//  Comic.swift
//  MarvelApp
//
//  Created by James Rochabrun on 1/7/21.
//

import Foundation

struct Comic: Decodable {
    let title: String
    let thumbnail: Artwork
}
