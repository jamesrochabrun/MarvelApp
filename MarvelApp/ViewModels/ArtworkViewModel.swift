//
//  ArtworkViewModel.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import Foundation

struct ArtworkViewModel {
    
    private let path: String
    private let extensionType: String
    
    init?(artWork: Artwork?) {
        guard
            let artWork = artWork,
            let path = artWork.path,
            let extensionType = artWork.extension
        else { return nil }
        self.path = path
        self.extensionType = extensionType
    }
    
    func imagePathFor(variant: ImageVariant) -> String {
        let uri = "\(path)/\(variant.rawValue).\(extensionType)"
        print(uri)
        return uri
    }
}

enum ImageVariant: String {
    
    // Portrait
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXLarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"

    // Square
    case squareStandardSmall = "standard_small"
    case squareStandardMedium = "standard_medium"
    case squareStandardLarge = "standard_large"
    case squareStandardXLarge = "standard_xlarge"
    case squareStandardFantastic = "standard_fantastic"
    case squareStandardAmazing = "standard_amazing"
    
    // Landscape
    case landscapeSmall = "landscape_small"
    case landscapeMedium = "landscape_medium"
    case landscapeLarge = "landscape_large"
    case landscapeXLarge = "landscape_xlarge"
    case landscapeAmazing = "landscape_amazing"
    case landscapeIncredible = "landscape_incredible"
    
    // Full size images
    case detail
    case fullSizeImage = "full-size image"
}
