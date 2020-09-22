//
//  MessageCell.swift
//  Podpocket
//
//  Created by Emin on 12.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct MessageCell: View {
    @StateObject var viewModel = FeedCellViewModel()
    @Binding var writing: Bool
    @Binding var actionSheet: ActionSheetData
    @State var showMore = false
    var message: MessageModel
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    
                    Image(uiImage: self.viewModel.profilePhoto)
                        .resizable().clipShape(Circle()).frame(width: 75, height: 75, alignment: .center)
                    
                    VStack(alignment: .leading) {
                        Text(self.viewModel.username).foregroundColor(.white)
                        Text(self.publishedAt(pubDateString: self.message.date)).foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                }.padding()
                Text(self.message.message).foregroundColor(.white).lineLimit(self.showMore ? nil : 5)
                
                
                if self.message.message.count > 100 {
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
                            Text(self.showMore ? "Shrink" : "Show More")
                            
                        }.foregroundColor(Color.podpocketGreenColor)
                    }
                }
                
                
            }.padding()
            
            .onAppear(perform: {
                self.viewModel.fetchUserInfo(uid: message.uid)
                
            })
            .background(Color.podpocketPurpleColor)
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
            
            if self.viewModel.getCurrentId() == self.message.uid {
                Button(action: {
                    self.actionSheet.tapped = true
                    self.actionSheet.messageId = self.message.id
                }, label: {
                    Image("more")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white).opacity(0.75)
                        .frame(width: 30, height: 30)
                        .padding([.top, .trailing], 30)
                })
            }
        }
        
        
        
        
    }
    
    func publishedAt(pubDateString: String) -> String {
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: Date())
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let pubDate = df.date(from: pubDateString) ?? Date()
        
        let date2 = calendar.startOfDay(for: pubDate)
        
        let components = calendar.dateComponents([.day], from: date2, to: date1)
        
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

@available(iOS 14.0, *)
struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell(
            writing: .constant(false),
            actionSheet: .constant(ActionSheetData(tapped: false, messageId: "")),
            message: MessageModel(countryCode: "TR", date: "13/02/2020", message: "Test", uid: "WCTMLaPIGodm1vESQkRqighC18W2")
        )
        
        
    }
}


