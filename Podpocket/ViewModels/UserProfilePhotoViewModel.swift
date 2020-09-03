//
//  UserProfilePhotoViewModel.swift
//  Podpocket
//
//  Created by Emin on 1.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserProfilePhotoViewModel {
    func savePhoto(image: UIImage) {
        
        FirebaseConnection.shared.saveImage(image: image)
        
    }
   
    func fetchImage(completion: ((UIImage?)->())? = nil) {
        FirebaseConnection.shared.fetchProfilePhoto { (image) in
            if let image = image {

                completion?(image)


            }
        }
        
    }
}
