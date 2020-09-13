//
//  FeedTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct FeedTabView: View {
    
    @ObservedObject var viewModel = FeedTabViewModel()
    
    @State var showMore = false
    @State var writing = false
    @State var message = ""

    init() {
        self.viewModel.fetchMessages()
        self.viewModel.observe()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                Color.init(hex: Color.podpocketPurpleColor)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture{
                        withAnimation {
                            self.writing = false
                        }
                        
                    }
                VStack {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: .infinity))], content: {
                            ForEach(self.viewModel.messages.reversed(), id: \.id) { message in
                                FeedCell(message: message, writing: self.$writing)

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
                    
                    VStack {
                        MultilineTextField("What's going on?", text: self.$message)
                            .padding()
                            .background(Color.init(hex: Color.podpocketPurpleColor).opacity(0.8))

                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.init(hex: Color.podpocketGreenColor), lineWidth: 2)
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
                                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                                Spacer()
                            }
                            .padding(5)
                            .background(Color.init(hex: Color.podpocketPurpleColor))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.init(hex: Color.podpocketGreenColor), lineWidth: 2)
                            )
                            .shadow(radius: 10)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        })
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
