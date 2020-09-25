//
//  LastListenedView.swift
//  Podpocket
//
//  Created by Emin on 25.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct LastListenedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = LastListenedViewModel()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Image("search2")
                            .resizable()
                            .frame(width: geometry.size.height / 22.3, height: geometry.size.height / 22.3)
                            
                            .hidden()
                            .overlay(
                                
                                Image("dmm")
                                    .resizable()
                                    .frame(width: geometry.size.height / 2.5, height: geometry.size.height / 2.5)
                                
                            )
                            .padding(.trailing, 30)
                            .padding(.top, 30)
                        
                    }
                    Spacer()
                }
                
                VStack {
                    HStack {
                        self.backButton()
                        Spacer()
                        
                    }
                    .padding()
                    
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width: geometry.size.height / 15, height: geometry.size.height / 15)
                        Text("Podpocket")
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    
                    ScrollView {
                        HStack {
                            Text("PODCASTS")
                                .foregroundColor(.white)
                                .font(.title)
                            Spacer()
                        }.padding()
                        
                        ScrollView(.horizontal) {
                            
                            LazyHGrid(rows: [GridItem(.flexible())]) {
                                
                                ForEach(self.viewModel.lastListenedEpisodes, id: \.self) { episode in
                                    Text(episode.episodeId ?? "")
                                }
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                }
                
                
            }.onAppear {
                self.viewModel.fetchLastListened()
            }
            
        }.navigationBarBackButtonHidden(true)
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarHidden(true)
    }
    
    func backButton() -> AnyView {
        return AnyView(
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("back")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.podpocketGreenColor)
                    .frame(width: 25, height: 25, alignment: .center)
            })
        )
    }
}

@available(iOS 14.0, *)
struct LastListenedView_Previews: PreviewProvider {
    static var previews: some View {
        LastListenedView()
    }
}
