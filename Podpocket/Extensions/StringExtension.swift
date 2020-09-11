//
//  StringExtension.swift
//  Podpocket
//
//  Created by Emin on 11.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation

extension String {
    static func toEncodedURL(link: String? = "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg") -> URL? {
        if let encoded = link?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            
            return url
        }
        return nil
    }
}
