//
//  FeedCell.swift
//  Podpocket
//
//  Created by Emin on 12.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct FeedCell: View {
    @Binding var writing: Bool
    @State var showMore = false
    var message: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image("demoprofile").resizable().clipShape(Circle()).frame(width: 100, height: 100, alignment: .center)
                    VStack(alignment: .leading) {
                        Text("Username").foregroundColor(.white)
                        Text("1 month ago").foregroundColor(.white)
                    }
                }.padding()
                Text(self.message).foregroundColor(.white).lineLimit(self.showMore ? 6 : 2)
                
                
                
                Button(action: {
                    withAnimation {
                        if !self.writing {
                            self.showMore.toggle()

                        } else {
                            self.hideKeyboard()
                            self.writing = false
                        }

                    }
                }) {
                    HStack {
                        Image(systemName: self.showMore ? "minus" : "plus")
                        Text(self.showMore ? "Shrink" :"Show More")

                    }.foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                }
            }.padding()
            Spacer()
        }
        .background(Color.init(hex: Color.podpocketPurpleColor))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.3)
                .shadow(radius: 10)
        )
        .cornerRadius(16)
        .padding()
        .shadow(radius: 10)    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedCell(writing: Binding(get: {
            return false
        }, set: { (_) in
            
        }),message: "As adSDF sdfSDF ssdf SDFsdf sfGDFg DFGDFGDF dfgdfgdf fdgd fgdfgdfg dfgd gdfgdfgdg dfgdfgdf")

    }
}


