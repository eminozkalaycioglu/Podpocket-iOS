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
    @State var text = ""
    @State private var animate = false
    private let animationOne = Animation.linear(duration: 8).delay(0.2).repeatForever(autoreverses: false)
    
    var body : some View {
        
        let stringWidth = text.widthOfString(usingFont: UIFont.systemFont(ofSize: 20))
         ZStack {
            GeometryReader { geometry in
                Text(self.text).lineLimit(1)
                    .font(.system(size: 20))
                    .offset(x: self.animate ? -stringWidth * 2 : 0)
                    .animation(self.animationOne)
                    .onAppear() {
                        if geometry.size.width < stringWidth {
                            self.animate = true
                        }
                    }
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                
                Text(self.text).lineLimit(1)
                    .font(.system(size: 20))
                    .offset(x: self.animate ? 0 : stringWidth * 2)
                    .animation(self.animationOne)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
        }
    }
}
