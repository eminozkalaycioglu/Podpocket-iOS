//
//  UserProfileView.swift
//  Podpocket
//
//  Created by Emin on 7.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    var cellWidth = UIScreen.main.bounds.width - 8
    var body: some View {
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    
                    ZStack {
                        Color.init(hex: "1E1B26").frame(width: self.cellWidth, height: 220, alignment: .center)
                        HStack {
                            VStack(alignment: .leading) {
                                Image("demoprofile").resizable().frame(width: 100, height: 100)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .overlay(Circle().stroke(Color.init(hex: "50E3C2"), lineWidth: 4.0))
                                
                                Text("username")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                
                                Text("asdasfadfsfd@gmail.com")
                                    .foregroundColor(.white).opacity(0.5)
                                    .font(.subheadline)
                                    

                            }.padding()
                            Spacer()
                        }
                        
                    }.cornerRadius(20)
                    
                    self.drawCells(image: "Logo", text: "birinci")
                    self.drawCells(image: "Logo", text: "ikinci")
                    self.drawCells(image: "UserTab", text: "asd")
                    self.drawCells(image: "Logo", text: "adgdhdghdghsd")
                    self.drawCells(image: "ExploreTab", text: "fsgdfhd")
                    self.drawCells(image: "ExploreTab", text: "fsgdfhd")
                    self.drawCells(image: "ExploreTab", text: "fsgdfhd")

                    Spacer()
                }
            }
            
        }.navigationBarTitle("").navigationBarHidden(true)
        
        
    }
    
    func drawCells(image: String, text: String) -> AnyView {
        return AnyView(
            ZStack {
                Color.init(hex: "1E1B26").frame(width: self.cellWidth, height: 100, alignment: .center)
                HStack {
                    Image(image).resizable().frame(width: 30, height: 30, alignment: .center)
                        .padding()
                    Text(text).foregroundColor(.white)
                    Spacer()
                }.padding()
                
            }.cornerRadius(20)
        )
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
