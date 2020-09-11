//
//  PodcastDetailViewModel.swift
//  Podpocket
//
//  Created by Emin on 20.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class PodcastDetailViewModel: ObservableObject {
    @Published var podcast: Podcast?
    @Published var loading: Bool = false
    
    private var id: String! {
        didSet {

            self.fetch()
        }
    }
    
    func fetch() {
        self.loading = true
        ServiceManager.shared.fetchPodcastDetail(id: self.id, pubDate: nil) { (result) in
            switch result {
            case .success(let response):
                self.podcast = response
                self.loading = false
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
    
    
    func getTitle() -> String {
        return self.podcast?.title ?? ""
    }
    
    func getImageURL() -> String {
        return self.podcast?.image ?? ""
    }
    
    func setId(id: String) {
        self.id = id
    }
}
