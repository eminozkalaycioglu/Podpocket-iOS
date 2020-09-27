//
//  AboutPodcastView.swift
//  Podpocket
//
//  Created by Emin on 20.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct AboutPodcastView: View {
    @EnvironmentObject var viewModel: AboutPodcastViewModel
    @State var presentDetail = false
    @State var selectedId = ""
    
    var rootPodcast = Podcast()
    init(rootPodcast: Podcast) {
        self.rootPodcast = rootPodcast
    }

    let rows = [
        GridItem(.fixed(180))
        
    ]
    
    var body: some View {
        ZStack {
            
            Color.podpocketPurpleColor
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 15) {
                        if let description = self.viewModel.rootPodcast?.descriptionField {
                            Text("Description")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text(description)
                                .foregroundColor(.white)
                        }
                        
                        
                        Text("About")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        
                        self.drawInfo(title: "Country", content: self.viewModel.rootPodcast?.country)
                        self.drawInfo(title: "Language", content: self.viewModel.rootPodcast?.language)
                        self.drawInfo(title: "Publisher", content: self.viewModel.rootPodcast?.publisher)
                        self.drawInfo(title: "First Release Date", content: self.viewModel.rootPodcast?.earliestPubDateMs?.msToDate())

                    }
                    
                    if let data = self.viewModel.similarPodcasts.recommendations {
                        Text("Similar Podcasts")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: self.rows, spacing: 20) {
                                ForEach(data, id: \.self) { item in
                                    RecommendationPodcastCell(similarPodcasts: item)
                                        .onTapGesture {
                                            self.selectedId = item.id ?? ""
                                            self.presentDetail = true
                                        }
                                        
                                }


                            }.frame(height: 180)
                        }
                    }
                    Spacer()
                }.padding(.leading, 20)
                Spacer()
            }
            
            if self.presentDetail {
                NavigationLink("", destination: PodcastDetailView(id: self.selectedId), isActive: self.$presentDetail)
            }
            
            
            
        }.onAppear {
            self.viewModel.setRootPodcast(podcast: self.rootPodcast)
        }
        
    }
    
    func drawInfo(title: String, content: String?) -> AnyView? {
        if let content = content {
            return AnyView(
                Text("\(title): \(content)")
                    .foregroundColor(.white)
            )
        }
        else {
            return nil
        }
    }
    
    
}


struct AboutPodcastView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            AboutPodcastView(rootPodcast: Podcast(descriptionField: "asdasdassdas", id: "asd", language: "asd")).environmentObject(AboutPodcastViewModel())
        } else {
            // Fallback on earlier versions
        }
    }
}
