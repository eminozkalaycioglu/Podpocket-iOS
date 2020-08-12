//
//  EditProfileViewModel.swift
//  Podpocket
//
//  Created by Emin on 12.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    @Published var user: User = User()
    var oldUserInfo: User = User()
    func setUserInfo(user: User) {
        self.user = user
        self.oldUserInfo = user
    }
    
    func edit(completion: ((String?, Bool) -> ())? = nil) {
       
        FirebaseConnection.shared.updateUserInfo(oldUserInfo: self.oldUserInfo, newUsername: self.user.username, newEmail: self.user.mail, newFullName: self.user.fullName, newBirthday: self.user.birthday) { error, emailChanged in
            if error == nil {
                
                completion?(nil, emailChanged)
            }
            else {
                completion?(error, emailChanged)
            }
            
        }
    }
    
    func signOut() -> Bool {
        return FirebaseConnection.shared.signOut()
    }
}
