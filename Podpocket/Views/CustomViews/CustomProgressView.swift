//
//  CustomProgressView.swift
//  Podpocket
//
//  Created by Emin on 18.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct CustomProgressView: View {
    
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            Color.init(.black)
                .opacity(0.7)
                
            
            
            VStack {
                
                Image("Logo")
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                    .animation(self.isAnimating ? self.foreverAnimation(duration: 0.3) : .default)
                    .onAppear { self.isAnimating = true }
                    .onDisappear { self.isAnimating = false }
                
                
                Text("Podpocket")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                
            }
            
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    func foreverAnimation(duration: Double) -> Animation {
        return Animation.linear(duration: duration)
            .repeatForever(autoreverses: false)
    }
    
    
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
