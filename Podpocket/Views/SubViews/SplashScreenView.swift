//
//  SplashScreenView.swift
//  Podpocket
//
//  Created by Emin on 27.09.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct SplashScreenView: View {
    @State var isAnimatingRotation = false
    @State var isAnimatingExpansion = false
    @State var showContent = false
    @State private var degrees = 0.0
    @State var show = false
    var body: some View {
        
        if self.showContent {
            ContentView()
        }
        else {
            ZStack {
                Color.podpocketPurpleColor
                    .edgesIgnoringSafeArea(.all)
                    
                
                if self.show {
                    VStack {
                        
                        Image("Logo")
                            .resizable()
                            .rotationEffect(Angle(degrees: self.isAnimatingRotation ? 360 : 0.0))
                            .rotation3DEffect(.degrees(self.isAnimatingRotation ? self.degrees : 0.0), axis: (x: 1, y: 0, z: 1))

                            .frame(width: self.isAnimatingExpansion ? 200 : 120, height: self.isAnimatingExpansion ? 200 : 120, alignment: .center)
                            .animation(self.isAnimatingExpansion ? self.foreverAnimation(duration: 1) : .default)
                            
                            .onAppear {
                                withAnimation {
                                    self.degrees += 360

                                }
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                                    withAnimation {
                                        self.degrees += 360
                                        
                                    }
                                }
                                
                                withAnimation {
                                    
                                    self.isAnimatingExpansion = true
                                    self.isAnimatingRotation = true

                                    
                                }
                                
                                
                                
                            }
                            .onDisappear {

                                withAnimation {
                                    self.isAnimatingExpansion = false
                                    self.isAnimatingRotation = false
                                }
                            }
                        
                        Text("Podpocket")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            
                        
                    }
                }
                else {
                    Text("")
                }
                
                
            }.edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.show = true
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation {
                        self.showContent = true

                    }
                }
            }
        }
        
    }
    func foreverAnimation(duration: Double) -> Animation {
        return Animation.linear(duration: duration)
            .repeatForever(autoreverses: true)
    }
    
}

@available(iOS 14.0, *)
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}



