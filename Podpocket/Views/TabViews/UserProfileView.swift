//
//  UserProfileView.swift
//  Podpocket
//
//  Created by Emin on 7.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import MessageUI
struct UserProfileView: View {
    @ObservedObject var viewModel = UserProfileViewModel()
    
    @State var showAlert: Bool = false
    @State var presentContent: Bool = false
    @State var presentEditProfile: Bool = false
    var cellWidth = UIScreen.main.bounds.width - 8
    
    var editProfileView = EditProfileView()
    
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
                                
                                Text(self.viewModel.userInfo.username ?? "")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                
                                Text(self.viewModel.userInfo.mail ?? "")
                                    .foregroundColor(.white).opacity(0.5)
                                    .font(.subheadline)
                                
                                
                            }.padding()
                            .padding(.leading, 10)
                            Spacer()
                        }
                        
                    }.cornerRadius(20)
                    
                    self.drawCells(image: "Exit", text: "Exit")
                        .onTapGesture {
                            self.showAlert = true
                        }
                    
                    self.drawCells(image: "Logo", text: "Profile Settings")
                        .onTapGesture {
                            self.editProfileView.viewModel.setUserInfo(user: self.viewModel.userInfo)
                            self.presentEditProfile = true
                        }
                   
                    Spacer()
                }
            }
            
            NavigationLink("", destination: ContentView(), isActive: self.$presentContent)

            if self.viewModel.loading {
                ZStack {
                    Color.init(.gray).opacity(0.2).edgesIgnoringSafeArea(.all)
                    Color.init(.white).foregroundColor(.white).cornerRadius(20).frame(width: 150, height: 100, alignment: .center)
                    if #available(iOS 14.0, *) {
                        ProgressView("Loading").foregroundColor(.black)
                    }
                }
            }
            
            
        }.navigationBarTitle("").navigationBarHidden(true)
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("Exit"), message: Text("Are you sure?"), primaryButton: .default(Text("No")), secondaryButton: .default(Text("Yes"), action: {
                if self.viewModel.signOut() {
                    self.presentContent = true
                }
            })
            )
            
        }
        .sheet(isPresented: self.$presentEditProfile, onDismiss: {
            self.viewModel.getUserInfo()
        }, content: {
            self.editProfileView
        })
        
        
        
        
        
    }
    
    func drawCells(image: String, text: String) -> AnyView {
        return AnyView(
            ZStack {
                Color.init(hex: "1E1B26").frame(width: self.cellWidth, height: 100, alignment: .center)
                HStack {
                    Image(image).resizable().frame(width: 50, height: 50, alignment: .center)
                        .padding(5)
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
