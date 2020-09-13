//
//  FeedCellViewModel.swift
//  Podpocket
//
//  Created by Emin on 13.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine
import UIKit

class FeedCellViewModel: ObservableObject {
    @Published var username = ""
    @Published var profilePhoto = UIImage()
    
    
    func fetchUserInfo(uid: String) {
        FirebaseConnection.shared.fetchUserInfo(uid: uid) { (user) in
            self.username = user.username ?? ""
           
            
        }
        FirebaseConnection.shared.fetchProfilePhoto(uid: uid) { photo in
            self.profilePhoto = photo
        }
    }
    
    
}
