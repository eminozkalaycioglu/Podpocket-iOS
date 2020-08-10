//
//  HomepageView.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct HomepageView: View {
    @State var presentContent: Bool = false
    @State var selectedTab: Int = 0
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
                
                ExploreTabView().tabItem {
                    Image("ExploreTab").renderingMode(.template)
                    self.selectedTab == 0 ? Text("Explore") : Text("")
                }.tag(0)
                
                SearchTabView().tabItem {
                    Image("search").renderingMode(.template)
                    self.selectedTab == 1 ? Text("Search") : Text("")

                }.tag(1)
                
                FeedTabView().tabItem {
                    Image("LogoTab").renderingMode(.template)
                    self.selectedTab == 2 ? Text("Feed") : Text("")

                }.tag(2)
                
                UserProfileView().tabItem {
                    Image("UserTab").renderingMode(.template)
                    self.selectedTab == 3 ? Text("Profile") : Text("")

                }.tag(3)
                
            }.accentColor(Color.init(hex: "#50E3C2"))
            
            
            NavigationLink("", destination: ContentView(), isActive: self.$presentContent)
        }
        
    }
}

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        HomepageView()
    }
}
