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
    func saveProfilePhoto(image: UIImage) {
        FirebaseConnection.shared.saveProfilePhoto(image: image)
    }
   
    func fetchImage(completion: ((UIImage)->())? = nil) {
        FirebaseConnection.shared.fetchProfilePhoto(uid: FirebaseConnection.shared.getCurrentID() ?? "") { (image) in
            completion?(image)

        }
        
    }
}
