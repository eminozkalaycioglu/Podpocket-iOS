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
