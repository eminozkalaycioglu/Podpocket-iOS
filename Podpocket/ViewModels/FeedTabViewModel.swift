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
    
    @Published var messages = [MessageModel]()
    
    func share(message: String, completion: ((Bool)->())? = nil) {
        
        FirebaseConnection.shared.shareMessage(message: message) { (success) in
            completion?(success)
        }
    }
    
    func deleteMessage(messageId: String) {
        FirebaseConnection.shared.deleteMessage(messageId: messageId)
    }
    func observe() {
        FirebaseConnection.shared.observeMessages { (added) in
            if added {
                self.fetchMessages()
            }
        }
    }
    
    func fetchMessages() {
        FirebaseConnection.shared.fetchAllMessages { (messages) in
            self.messages = messages
        }
    }
}
