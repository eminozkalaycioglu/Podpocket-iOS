//
//  SearchResultPodcastCell.swift
//  Podpocket
//
//  Created by Emin on 29.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct SearchResultPodcastCell: View {
    var podcast: SearchResult
    var body: some View {
        VStack {
            
            if let url = String.toEncodedURL(link: self.podcast.image) {
                KFImage(url)
                    .cancelOnDisappear(true)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            Text(self.podcast.titleOriginal ?? "")
                .foregroundColor(.white)
                .frame(maxWidth: 100,minHeight: 25)
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .lineLimit(2)

        }
    }
}

struct SearchResultPodcastCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultPodcastCell(podcast: SearchResult(id: "1", titleOriginal: "Preview"))
    }
}
