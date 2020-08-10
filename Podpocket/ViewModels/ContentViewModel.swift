//
//  ContentViewModel.swift
//  Podpocket
//
//  Created by Emin on 5.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation

class ContentViewModel {
    
    func signed() -> Bool {
        return FirebaseConnection.shared.signed() ? true : false
    }
}
