//
//  ExploreTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct ExploreTabView: View {
    
    @StateObject var viewModel = ExploreTabViewModel()
    @State var presentDetail = false
    @State var selectedId = ""
    @Binding var tabSelection: Int
    
    let rows = [
        GridItem(.fixed(180)),
        GridItem(.fixed(180)),
        
    ]
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                Image("LoginBG")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        Image("search2")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height / 16, height: UIScreen.main.bounds.height / 16)
                            
                            .hidden()
                            .overlay(
                                
                                Image("dmm")
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.height / 2.1, height:  UIScreen.main.bounds.height / 2.1)
                                
                            )
                            .padding(.trailing, 28)
                            .padding(.top, 28)
                        
                    }
                    Spacer()
                }
                VStack(spacing: 0) {
                    HStack(alignment: .top) {
                        
                        HStack {
                            Image("Logo")
                                .resizable()
                                .frame(width: geometry.size.height / 15, height: geometry.size.height / 15)
                            Text("Podpocket")
                                .foregroundColor(.white)
                        }.padding()
                        
                        Spacer()
                        Image("search2").resizable().frame(width: UIScreen.main.bounds.height / 16, height: UIScreen.main.bounds.height / 16)
                            .padding(.trailing, 28)
                            .padding(.top, 28)
                            .onTapGesture {
                                self.tabSelection = 1
                            }
                    }
                    
                    
                    ScrollView {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("EXPLORE")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
                                Text("All your favourite\npodcasts under one roof!")
                                    .font(.system(size: 15))
                                    .fontWeight(.light)
                                    .foregroundColor(.gray)
                                
                            }.padding()
                            Spacer()
                        }
                        
                        VStack {
                            HStack {
                                Text("THE BEST PODCASTS IN YOUR REGION")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                Spacer()
                            }.padding()
                            
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: rows, spacing: 20) {
                                    if let data = self.viewModel.bestPodcasts?.podcasts {
                                        ForEach(data, id: \.self) { item in
                                            
                                            PodcastCell(podcast: item)
                                                .id(UUID())

                                                .onTapGesture {
                                                    self.selectedId = item.id ?? ""
                                                    self.presentDetail = true
                                                }
                                            
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal)
                            }
                            
                        }.padding(.top, 30)
                    }
                    
                    Spacer()
                }
                
                if self.viewModel.loading {
//                    CustomProgressView()
                    
                }

                
                NavigationLink("", destination: PodcastDetailView(id: self.selectedId), isActive: self.$presentDetail)
                
            }.navigationBarTitle("").navigationBarHidden(true)
            
        }
        
        
    }
}

struct ExploreTabView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ExploreTabView(tabSelection: Binding(get: {
                return 1
            }, set: { (_) in
                
            }))
        } else {
            // Fallback on earlier versions
        }
    }
}
