//
//  NSManagedObjectContextExtension.swift
//  Podpocket
//
//  Created by Emin on 24.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import CoreData
import UIKit
extension NSManagedObjectContext {
    
    static var current: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}

