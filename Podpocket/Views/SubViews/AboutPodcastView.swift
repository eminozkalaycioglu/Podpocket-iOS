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
        
//        self.viewModel.setRootPodcast(podcast: rootPodcast)
        self.rootPodcast = rootPodcast


    }

    let rows = [
        GridItem(.fixed(180))
        
    ]
    
    var body: some View {
        ZStack {
            
            Color.init(hex: Color.podpocketPurpleColor)
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Description")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text(self.viewModel.rootPodcast?.descriptionField ?? "")
                        .foregroundColor(.white)
                    
                    Text("About")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Country: \(self.viewModel.rootPodcast?.country ?? "")")
                        .foregroundColor(.white)
                    
                    Text("Language: \(self.viewModel.rootPodcast?.language ?? "")")
                        .foregroundColor(.white)
                    
                    
                    Text("Publisher: \(self.viewModel.rootPodcast?.publisher ?? "")")
                        .foregroundColor(.white)
                    
                    Text("First Release Time: \((self.viewModel.rootPodcast?.earliestPubDateMs ?? 0).msToDate())")
                        .foregroundColor(.white)
                    
                    Text("Similar Podcasts")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: self.rows, spacing: 20) {
                            if let data = self.viewModel.similarPodcasts.recommendations {
                                ForEach(data, id: \.self) { item in
                                    RecommendationPodcastCell(similarPodcasts: item)
                                        .onTapGesture {
                                            self.selectedId = item.id ?? ""
                                            self.presentDetail = true
                                        }
                                        
                                }
                            }

                        }
                    }

                    
                    Spacer()
                    
                    
                }.padding(.leading, 20)
                Spacer()
            }
            
            NavigationLink("", destination: PodcastDetailView(id: self.selectedId), isActive: self.$presentDetail)
            
        }.onAppear {
            self.setRootPodcast()
        }
        
        
        
        
    }
    
    func setRootPodcast() {
        self.viewModel.setRootPodcast(podcast: self.rootPodcast)
    }
    
}


//struct AboutPodcastView_Previews: PreviewProvider {
//    static var previews: some View {
//        if #available(iOS 14.0, *) {
//            AboutPodcastView(podcast: Podcast(country: "as", descriptionField: "Asadfs sfgsgj sgjfbsgj sh bsfhgshgb shg sh sdhbfshdfs sdhbf sdhbfsdhbf sf bhsfbhsfbhs fhbs fhbsh sf ",  email: "as",  id: "9392aab5fe0c4998ac9dcf35316ee760", image: "as", language: "as", listennotesUrl: "as", publisher: "as", rss: "as", thumbnail: "as", title: "as", type: "as", website: "as"), similarPodcasts: SimilarPodcasts())
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}
