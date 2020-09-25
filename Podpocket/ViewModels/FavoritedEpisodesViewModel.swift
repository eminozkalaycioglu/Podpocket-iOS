//
//  FavoritedEpisodesViewModel.swift
//  Podpocket
//
//  Created by Emin on 23.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class FavoritedEpisodesViewModel: ObservableObject {
    @Published var favoritedEpisodes = [FavoritedEpisodeModel]()
    
    func fetchAllFavoritedEpisodes() {
        FirebaseConnection.shared.fetchAllFavoritedEpisodes { (favoritedEpisodes) in
            self.favoritedEpisodes = favoritedEpisodes
        }
    }
    
}
