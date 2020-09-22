//
//  ContentView.swift
//  Podpocket
//
//  Created by Emin on 28.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct ContentView: View {
    var viewModel = ContentViewModel()
    var body: some View {

        NavigationView {
            if self.viewModel.signed() {
                
                
                HomepageView()
//                PlayerView(episode: Episode(audio: "http://www.hochmuth.com/mp3/Haydn_Adagio.mp3",image: "https://cdn-images-1.listennotes.com/episode/image/1ea160e09e7e40e5970a8651a5835d6b.jpg", title: "asdASDASdf ADfsDF dsFsdFSDFS sdfSDFSFds FS FSDFSDF sdF SDFSDSFs sdfs dfsds"), parentPodcastId: "")
            }
            else {
                LoginView()
            }
        }.navigationBarTitle("").navigationBarHidden(true)
       

    }
}

@available(iOS 14.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
