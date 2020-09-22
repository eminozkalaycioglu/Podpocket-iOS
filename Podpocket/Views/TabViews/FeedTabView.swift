//
//  FeedTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

enum FetchType {
    case Local
    case Worldwide
}

@available(iOS 14.0, *)
struct FeedTabView: View {
    @State var writing = false
    @State var selectedSegment = 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    ZStack {
                        Picker("", selection: self.$selectedSegment) {
                            Text("LOCAL")
                                .tag(0)
                            Text("WORLWIDE")
                                .tag(1)
                            
                        }.shadow(radius: 10)
                        .frame(height: 60)
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.init(hex: "2C2838"))
                        if self.writing {
                            Color.black.opacity(0.7)
                                .edgesIgnoringSafeArea(.all)
                                .frame(height: 60)
                                
                        }
                    }
                    
                   
                    switch self.selectedSegment {
                    case 0:
                        MessagesView(type: .Local, writing: self.$writing)
                    case 1:
                        MessagesView(type: .Worldwide, writing: self.$writing)
                    default:
                        Text("")
                    }
                    
                }
                
                
                 
                
            }.navigationBarTitle("").navigationBarHidden(true)
        }
    }
}

@available(iOS 14.0, *)
struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
