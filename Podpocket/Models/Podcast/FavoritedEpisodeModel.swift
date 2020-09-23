//
//  FavoritedEpisodeModel.swift
//  Podpocket
//
//  Created by Emin on 23.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation

struct FavoritedEpisodeModel: Hashable {
    var id = UUID()
    var episodeId: String
    var title: String
    var pubDateMs: Int
}
