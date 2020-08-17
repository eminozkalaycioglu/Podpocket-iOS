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
                            .frame(width: geometry.size.height / 20.3, height: geometry.size.height / 20.3)
                            .hidden()
                            .overlay(Image("dmm")
                                        .resizable()
                                        .frame(width: geometry.size.height / 2.5, height: geometry.size.height / 2.5))
                            .padding(.trailing, 30)
                            .padding(.top, 30)
                    }
                    Spacer()
                }
                    
                
                
                

                VStack(spacing: 0) {
                    HStack(alignment: .top) {
                        
                        HStack {
                            Image("Logo")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Podpocket")
                                .foregroundColor(.white)
                        }.padding()
                        
                        Spacer()
                        Image("search2").resizable().frame(width: geometry.size.height / 20.3, height: geometry.size.height / 20.3)
                            .padding(.trailing, 30)
                            .padding(.top, 30)
                            .onTapGesture {
                                print("clicked")
                            }
                    }

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
                    
                    Text(Locale.current.regionCode ?? "yok")
                   
                        
                    Spacer()
                }
            }.navigationBarTitle("").navigationBarHidden(true)
        }
        
        
    }
}

struct ExploreTabView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTabView()
    }
}
