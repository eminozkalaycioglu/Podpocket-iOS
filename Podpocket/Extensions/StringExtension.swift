//
//  StringExtension.swift
//  Podpocket
//
//  Created by Emin on 11.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static func toEncodedURL(link: String? = "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg") -> URL? {
        if let encoded = link?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            
            return url
        }
        return nil
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
