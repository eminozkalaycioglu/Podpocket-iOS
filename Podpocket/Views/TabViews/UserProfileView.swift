//
//  UserProfileView.swift
//  Podpocket
//
//  Created by Emin on 7.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
import MessageUI

@available(iOS 14.0, *)
struct UserProfileView: View {
    @ObservedObject var viewModel = UserProfileViewModel()
    
    @State var show: Bool = false
    @State var selectedImage: UIImage = UIImage(named: "profile")!
    @State var showAlert: Bool = false
    @State var presentContent: Bool = false
    @State var presentEditProfile: Bool = false
    @State var presentFavoritedEpisodesView: Bool = false
    @State var presentLastListenedView = false
    @State var loading = false
    var cellWidth = UIScreen.main.bounds.width - 8
    
    var editProfileView = EditProfileView()
    
    var body: some View {
        ZStack {
            
            ZStack {
                Image("LoginBG")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        
                        ZStack {
                            
                            if !self.show {
                                Color.init(hex: "1E1B26").frame(width: self.cellWidth, height: 220, alignment: .center)
                            }
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    UserProfilePhotoView(showCaptureImageView: self.$show, image: self.$selectedImage)
                                    
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
                        
                        self.drawCells(image: "ProfileSettings", text: "Profile Settings")
                            .onTapGesture {
                                self.editProfileView.viewModel.setUserInfo(user: self.viewModel.userInfo)
                                self.presentEditProfile = true
                            }
                        
                        self.drawCells(image: "Favorites", text: "Favorited Episodes")
                            .onTapGesture {
                                self.presentFavoritedEpisodesView = true
                            }
                        
                        self.drawCells(image: "Logo", text: "Last Listened")
                            .onTapGesture {
                                self.presentLastListenedView = true
                            }
                            
                        
                        Spacer()
                    }
                }
                
                
                NavigationLink("", destination: ContentView(), isActive: self.$presentContent)
                NavigationLink("", destination: FavoritedEpisodes(), isActive: self.$presentFavoritedEpisodesView)
                NavigationLink("", destination: LastListenedView(), isActive: self.$presentLastListenedView)

                
                if self.viewModel.loading {
                    CustomProgressView()

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
            
            ZStack {
//                for multiple sheet
            }.sheet(isPresented: self.$show, content: {
                CaptureImageView(isShown: self.$show, image: self.$selectedImage)
            })
            ZStack {
//                for multiple sheet
            }.sheet(isPresented: self.$presentEditProfile, onDismiss: {
                if !self.viewModel.signed() {
                    self.presentContent = true
                }
                else {
                    self.viewModel.getUserInfo()
                    
                }
            }, content: {
                self.editProfileView
            })
            
            
        }
        
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

@available(iOS 14.0, *)
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
    
}
