//
//  SignUpViewModel.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    
    
    @Published var presentHomePage: Bool = false
    
    func signUp(email: String, password: String, fullName: String, username: String, birthday: String, completion: ((String?) -> ())? = nil) {
        FirebaseConnection.shared.createUser(fullName: fullName, email: email, pass: password, username: username, birthday: birthday) { (errorStr) in
            if errorStr == nil {
                self.presentHomePage = true
                completion?(nil)
            }
            else {
                completion?(errorStr)
            }
            
            
        }
    }
}
