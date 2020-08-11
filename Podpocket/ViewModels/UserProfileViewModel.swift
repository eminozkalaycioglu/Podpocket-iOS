//
//  UserProfileViewModel.swift
//  Podpocket
//
//  Created by Emin on 11.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var userInfo: User = User()
    @Published var loading: Bool = true
    
    var uid: String = FirebaseConnection.shared.getCurrentID() ?? ""
    
    init() {
        self.getUserInfo()
    }
    
   
    
    func getUserInfo() {
        FirebaseConnection.shared.fetchUserInfo(uid: self.uid) { (user) in
            if user != nil {
                self.userInfo = user!
                self.loading = false
            }
        }
    }
    
    func signOut() -> Bool {
        return FirebaseConnection.shared.signOut()
    }
}
