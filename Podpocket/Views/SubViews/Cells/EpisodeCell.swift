//
//  EpisodeCell.swift
//  Podpocket
//
//  Created by Emin on 4.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct EpisodeCell: View {
    var episode: Episode
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Image("play")
            }).padding(.leading)
            VStack(alignment: .leading) {
                Text(episode.title ?? "Notitle")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .lineLimit(3)
                    .padding(.bottom, 1)
                    
                Text(episode.pubDateMs?.msToDate() ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 10))

            }.padding()
            Spacer()

        }.background(Color.init(hex: Color.podpocketPurpleColor))
        
    }
}

struct EpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeCell(episode: Episode(id: "a", pubDateMs: 12124234, title: "Episo deTifsfdsf dfgd dfg d"))
    }
}
