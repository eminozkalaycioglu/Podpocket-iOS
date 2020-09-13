//
//  UserProfilePhotoView.swift
//  Podpocket
//
//  Created by Emin on 1.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct UserProfilePhotoView: View {
    @Binding var showCaptureImageView: Bool
    @Binding var image: UIImage?
    
    var viewModel = UserProfilePhotoViewModel()
    
   
    var body: some View {
        
        ZStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable().frame(width: 100, height: 100)
                        .onChange(of: self.image, perform: { newImage in
                            print("image changed")
                            if let newImage = newImage {
                                self.viewModel.savePhoto(image: newImage)

                            }
                        })
                }
                
                
                else {
                    Image("profile")
                        .resizable().frame(width: 100, height: 100)
                        
                }
                
                
                Color.black
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: 100, minHeight: 0, idealHeight: 15, maxHeight: 15, alignment: .center)
                    .opacity(0.7)
                
                Button(action: {
                    withAnimation {
                        
                        self.showCaptureImageView.toggle()

                    }
                }, label: {
                    Image(systemName: "arrow.clockwise.circle").resizable().frame(width: 12, height: 12, alignment: .top).foregroundColor(.white).opacity(1)
                }).padding(.bottom, 2)
                
                
               
                
                
            }.clipShape(Circle())
            .overlay(Circle().stroke(Color.init(hex: "50E3C2"), lineWidth: 3.0))
            .shadow(radius: 6)
        
            
        }
        
        
        .onAppear {
            self.viewModel.fetchImage { (originalImage) in
                
                self.image = originalImage
            }
        }
        
        
        
        //
    }
}

//@available(iOS 14.0, *)
//struct UserProfilePhotoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfilePhotoView()
//    }
//}
