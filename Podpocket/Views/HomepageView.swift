//
//  HomepageView.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    @State var selectedTab: Int = 3
    
    init() {
        UITabBar.appearance().backgroundImage = UIImage(named: "LoginBG")
        UITabBar.appearance().barTintColor = .clear
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
        UITabBar.appearance().clipsToBounds = true
     }
    var body: some View {
        ZStack {
            
            TabView(selection: self.$selectedTab) {
                
                if #available(iOS 14.0, *) {
                    ExploreTabView(tabSelection: self.$selectedTab)
                        .tabItem {
                            Image("ExploreTab")
                                .renderingMode(.template)
                            self.selectedTab == 0 ? Text("Explore") : Text("")
                        }.tag(0)
                } else {
                }
                
                if #available(iOS 14.0, *) {
                    SearchTabView().tabItem {
                        Image("search").renderingMode(.template)
                        self.selectedTab == 1 ? Text("Search") : Text("")
                        
                    }.tag(1)
                } else {
                    // Fallback on earlier versions
                }
                
                FeedTabView().tabItem {
                    Image("LogoTab").renderingMode(.template)
                    self.selectedTab == 2 ? Text("Feed") : Text("")

                }.tag(2)
                
                if #available(iOS 14.0, *) {
                    UserProfileView().tabItem {
                        Image("UserTab").renderingMode(.template)
                        self.selectedTab == 3 ? Text("Profile") : Text("")
                        
                    }.tag(3)
                } else {
                    // Fallback on earlier versions
                }
                
                
                
            }.accentColor(Color.init(hex: "#50E3C2"))
            
            
            
        }
        
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
