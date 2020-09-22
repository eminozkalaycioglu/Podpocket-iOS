//
//  File.swift
//  Podpocket
//
//  Created by Emin on 21.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import SwiftUI
struct MarqueeText : View {
    @State var text: String
    @State private var animate = false
    private let animationOne = Animation.linear(duration: 8).repeatForever(autoreverses: false)
    
    var body : some View {
        
        let stringWidth = self.text.widthOfString(usingFont: UIFont.systemFont(ofSize: 20))
        return ZStack {
            Text(self.text).lineLimit(1)
                .font(.system(size: 20))
                .offset(x: -stringWidth * 2)
                .animation(self.animationOne)
                
                .fixedSize(horizontal: true, vertical: false)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            
            Text(self.text).lineLimit(1)
                .font(.system(size: 20))
                .offset(x: 0 )
                .animation(self.animationOne)
                .fixedSize(horizontal: true, vertical: false)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        }
        
    }
}
