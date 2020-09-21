//
//  MarqueeLabel.swift
//  Podpocket
//
//  Created by Emin on 21.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import MarqueeLabel

struct MarqueeLabelView: UIViewRepresentable {
    
    
    @Binding var text: String
    var targetFrame: CGRect
    func makeUIView(context: Context) -> MarqueeLabel {
        return MarqueeLabel.init(frame: self.targetFrame)
    }

    func updateUIView(_ uiView: MarqueeLabel, context: Context) {
        uiView.text = text
        
        uiView.type = .continuous
        uiView.scrollDuration = 5.0
        uiView.animationCurve = .easeInOut
        uiView.fadeLength = 10.0
        uiView.leadingBuffer = 30.0
        uiView.trailingBuffer = 20.0
        
        
    }
}
