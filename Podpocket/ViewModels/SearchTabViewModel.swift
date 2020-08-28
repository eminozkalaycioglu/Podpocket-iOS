//
//  SearchTabViewModel.swift
//  Podpocket
//
//  Created by Emin on 28.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class SearchTabViewModel: ObservableObject {
    @Published var selections: [String] = []

    @Published var genres: Genres = Genres()
    @Published var results = [SearchResult]()
    @Published var loading = false
    var lastResults = SearchModel()
    
    init() {
        self.fetchGenres()
    }
    
    private func fetchGenres() {
        self.loading = true
        ServiceManager.shared.fetchGenres { (result) in
            switch result {
            case .success(let response):
                self.genres = response
                self.loading = false
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
    
    func search(query: String, offset: Int) {
        self.loading = true
        
        ServiceManager.shared.search(query: query, type: .Podcast, offset: offset, genres: self.selections.count == 0 ? nil : self.selections) { (result) in
            switch result {
            case .success(let response):
                self.lastResults = response
                self.results += response.results ?? [SearchResult]()
                self.loading = false
            case .failure(_):
                print("error!")
                self.loading = false
            }
        }
    }
    
    func searchNextOffset(query: String) {
        self.search(query: query, offset: self.lastResults.nextOffset ?? 0)
    }
}
