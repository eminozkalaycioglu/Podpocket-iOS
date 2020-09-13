//
//  FeedCell.swift
//  Podpocket
//
//  Created by Emin on 12.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct FeedCell: View {
    @StateObject var viewModel = FeedCellViewModel()
    @Binding var writing: Bool
    @State var showMore = false
    var message: MessageModel
    
    init(message: MessageModel, writing: Binding<Bool>) {
        self.message = message
        self._writing = writing

    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: self.viewModel.profilePhoto)
                        .resizable().clipShape(Circle()).frame(width: 100, height: 100, alignment: .center)
                    
                    VStack(alignment: .leading) {
                        Text(self.viewModel.username).foregroundColor(.white)
                        Text(self.publishedAt(pubDateString: self.message.date)).foregroundColor(.white)
                    }
                }.padding()
                Text(self.message.message).foregroundColor(.white).lineLimit(self.showMore ? 6 : 2)
                
                
                
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
        }.onAppear(perform: {
            self.viewModel.fetchUserInfo(uid: message.uid)

        })
        .background(Color.init(hex: Color.podpocketPurpleColor))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 0.3)
                .shadow(radius: 10)
        )
        .cornerRadius(16)
        .padding()
        .shadow(radius: 10)
        .onAppear {
            self.viewModel.fetchUserInfo(uid: message.uid)
            print("fetch")
            
        }
        
       
        
    }
    
    func publishedAt(pubDateString: String) -> String {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: Date())
        
        let df = DateFormatter()
        df.dateFormat = "dd//MM/yyy"
        let pubDate = df.date(from: pubDateString) ?? Date()
        
        let date2 = calendar.startOfDay(for: pubDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        if let day = components.day {
            if day == 0 {
                return "Today"
            }
            else {
                return day == 1 ? "\(day) day ago" : "\(day) days ago"
            }
        } else {
            return ""
        }
        
        
    }
}

//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell(writing: Binding(get: {
//            return false
//        }, set: { (_) in
//
//        }),message: MessageModel(countryCode: "TR", date: "13/02/2020", message: "Test", uid: "sdfsfsfsgs"))
//
//    }
//}
//
//
