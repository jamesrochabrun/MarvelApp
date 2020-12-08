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
    
    func imageVariant(_ variant: ImageVariants) -> String {
        let t = "\(path)/\(variant.rawValue)/.\(extensionType)"
        print("zizou \(t)")
       // return t
        return "http://i.annihil.us/u/prod/marvel/i/mg/3/40/4bb4680432f73/\(variant.rawValue).\(extensionType)"
    }
}

enum ImageVariants: String {
    
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
