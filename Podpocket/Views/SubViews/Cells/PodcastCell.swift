//
//  PodcastCell.swift
//  Podpocket
//
//  Created by Emin on 18.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct PodcastCell: View {
    var podcast: Podcast?
    var body: some View {
        VStack {
            
            if let url = String.toEncodedURL(link: podcast?.image) {
                KFImage(url)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            
            Text(self.podcast?.title ?? "")
                .foregroundColor(.white)
                .frame(maxWidth: 100,minHeight: 25)
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text("\(self.podcast?.totalEpisodes ?? 0) episodes")
                
                .font(.system(size: 8))
                .fontWeight(.light)
                .foregroundColor(Color.podpocketGreenColor)
        }
        
        
        
        
        
    }
}

struct PodcastCell_Previews: PreviewProvider {
    static var previews: some View {
        
        PodcastCell(podcast: Podcast())
    }
}
