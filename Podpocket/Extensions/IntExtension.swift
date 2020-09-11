//
//  IntExtension.swift
//  Podpocket
//
//  Created by Emin on 4.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation


extension Int {
    func msToDate() -> String {
        let date = Date(timeIntervalSince1970: (Double(self) / 1000.0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
