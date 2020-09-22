//
//  LocalMessagesView.swift
//  Podpocket
//
//  Created by Emin on 15.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct MessagesView: View {
    
    @ObservedObject var viewModel = FeedTabViewModel()
    @Binding var writing: Bool
    @State var message = ""
    @State var actionSheet = ActionSheetData(tapped: false, messageId: "")
    
    
    init(type: FetchType, writing: Binding<Bool>) {
        self._writing = writing

        self.viewModel.fetchMessages(type: type)
        self.viewModel.observe(type: type)
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            self.writing = false
                        }
                    }
                
                
                VStack {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: .infinity))], content: {
                            ForEach(self.viewModel.messages.reversed(), id: \.id) { message in
                                MessageCell(writing: self.$writing, actionSheet: self.$actionSheet, message: message)
                                
                                
                            }
                        })
                    }
                }.onTapGesture {
                    withAnimation {
                        self.writing = false
                    }
                }
                if !self.writing {
                    
                    Button(action: {
                        withAnimation {
                            self.writing.toggle()
                        }
                    }, label: {
                        Image("share")
                            .resizable()
                            .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                    }).padding()
                    
                } else {
                    ZStack(alignment: .bottom) {
                        Color.black.opacity(0.7).onTapGesture {
                            self.writing = false
                        }
                        VStack {
                            MultilineTextField("What's going on?", text: self.$message)
                                .padding()
                                .background(Color.podpocketPurpleColor.opacity(0.8))
                                
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.podpocketGreenColor, lineWidth: 2)
                                )
                                .shadow(radius: 10)
                                .padding()
                            
                            Button(action: {
                                self.viewModel.share(message: self.message) { (success) in
                                    if success {
                                        self.writing = false
                                    }
                                }
                                
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("SHARE")
                                        .font(.title2)
                                        .foregroundColor(Color.podpocketGreenColor)
                                    Spacer()
                                }
                                .padding(5)
                                .background(Color.podpocketPurpleColor)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.podpocketGreenColor, lineWidth: 2)
                                )
                                .shadow(radius: 10)
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            })
                        }
                        
                        
                    }
                    
                }
                
            }.actionSheet(isPresented: self.$actionSheet.tapped) {
                ActionSheet(title: Text("Options"), message: Text("What would you like to do?"), buttons: [
                    .destructive(Text("Delete"),action: {
                        self.viewModel.deleteMessage(messageId: self.actionSheet.messageId)
                    }),
                    
                    .cancel()
                ])
            }
            
        }
    }
}

struct ActionSheetData {
    var tapped: Bool
    var messageId: String
}

@available(iOS 14.0, *)
struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(type: .Local, writing: .constant(false))
    }
}
