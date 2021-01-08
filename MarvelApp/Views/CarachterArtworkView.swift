//
//  CarachterArtworkView.swift
//  MarvelApp
//
//  Created by James Rochabrun on 12/7/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct CarachterArtworkView: View {
    
    var artworkViewModel: ArtworkViewModel?
    var variant: ImageVariant
    
    var body: some View {
        let url = artworkViewModel?.imagePathFor(variant: variant) ?? ""
        WebImage(url: URL(string: url))
           // Supports options and context, like `.delayPlaceholder` to show placeholder only when error
           .onSuccess { image, data, cacheType in
               // Success
            // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
           }
            .resizable() // Resizable like SwiftUI.Image, you must use this modifier or the view will use the image bitmap size
            .placeholder(Image(systemName: "photo")) // Placeholder Image
            // Supports ViewBuilder as well
                       .placeholder {
                           Rectangle().foregroundColor(.gray)
                       }
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
          //  .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CarachterArtworkView_Previews: PreviewProvider {
    static var previews: some View {
        CarachterArtworkView(artworkViewModel: ArtworkViewModel(artWork: Artwork(path: "some", imageExtension: "somen"))!, variant: .detail)
    }
}
