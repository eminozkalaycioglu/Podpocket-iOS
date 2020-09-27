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
struct UserProfileTabView: View {
    
    @ObservedObject var viewModel = UserProfileViewModel()
    @State var selectedImage: UIImage = UIImage(named: "profile")!
    @State var showAlert: Bool = false
    @State var presentContent: Bool = false
    @State var presentEditProfile: Bool = false
    @State var presentCaptureImage: Bool = false
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
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                UserProfilePhotoView(showCaptureImageView: self.$presentCaptureImage, image: self.$selectedImage)
                                
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
                        }.background(Color.init(hex: "1E1B26"))
                        .cornerRadius(20)
                        .padding(.horizontal, 5)
                        
                        self.drawCells(image: "Favorites", text: "Favorited Episodes")
                            .onTapGesture {
                                self.presentFavoritedEpisodesView = true
                            }
                        
                        self.drawCells(image: "lastListened", text: "Last Listened")
                            .onTapGesture {
                                self.presentLastListenedView = true
                            }
                        
                        
                        self.drawCells(image: "ProfileSettings", text: "Profile Settings")
                            .onTapGesture {
                                self.editProfileView.viewModel.setUserInfo(user: self.viewModel.userInfo)
                                self.presentEditProfile = true
                            }
                        self.drawCells(image: "Exit", text: "Exit")
                            .onTapGesture {
                                self.showAlert = true
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
            
            ZStack {}.sheet(isPresented: self.$presentCaptureImage, content: {
                CaptureImageView(isShown: self.$presentCaptureImage, image: self.$selectedImage)
            })//for multiple sheet

            ZStack {}.sheet(isPresented: self.$presentEditProfile, onDismiss: {
                if !self.viewModel.signed() {
                    self.presentContent = true
                }
                else {
                    self.viewModel.getUserInfo()
                    
                }
            }, content: {
                self.editProfileView
            })//for multiple sheet

        }
        
    }
    
    func drawCells(image: String, text: String) -> AnyView {
        return AnyView(
            HStack {
                Image(image).resizable().frame(width: 50, height: 50, alignment: .center)
                    .padding(5)
                Text(text).foregroundColor(.white)
                Spacer()
            }.padding()
            .background(Color.init(hex: "1E1B26"))
            .cornerRadius(20)
            .padding(.horizontal, 5)
        )
    }
}

@available(iOS 14.0, *)
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileTabView()
    }
    
}
