//
//  FeedTabViewModel.swift
//  Podpocket
//
//  Created by Emin on 12.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import Combine

class FeedTabViewModel: ObservableObject {
    
    @Published var success = false
    func share(message: String) {
        self.success = false
        FirebaseConnection.shared.shareMessage(message: message) { (success) in
            
            if success {
                self.success = true
            }
            else {
                self.success = false
            }
        }
    }
}
