//
//  LoginViewModel.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var presentHomePage: Bool = false
    
    func login(email: String, password: String) {
        FirebaseConnection.shared.signIn(withEmail: email, password: password) { (errorStr) in
            self.presentHomePage = (errorStr == nil)
        }
    }
    
}
