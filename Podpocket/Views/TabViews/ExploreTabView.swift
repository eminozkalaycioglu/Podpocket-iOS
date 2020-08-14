//
//  ExploreTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct ExploreTabView: View {
    var body: some View {
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            Image("dm").offset(x: 130, y: -100)

            VStack {
                ZStack {
                }
                Text("explore, World!").foregroundColor(.white)
            }
        }    }
}

struct ExploreTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTabView()
    }
}
