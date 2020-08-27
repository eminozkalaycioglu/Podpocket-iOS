//
//  SearchTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct SearchTabView: View {
    var body: some View {
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("search, World!").foregroundColor(.white)
                Button("Search") {
                    ServiceManager.shared.search(query: "star", type: .Podcast, offset: 0, genres: ["69","83"]) { (result) in
                        switch result {
                        case .success(let response):
                            print(response.results?.first?.id ?? "yok")
                            print(response.results?.first?.titleOriginal ?? "yok")

                        case .failure(_):
                            print("errorrrr")
                        }
                    }
                }
            }
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
    }
}
