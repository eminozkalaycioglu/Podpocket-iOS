//
//  SaveButtonView.swift
//  Podpocket
//
//  Created by Emin on 14.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct SaveButtonView: View {
    var text: String? = nil
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Circle().stroke(Color.white.opacity(0.3), lineWidth: 1).frame(width: 50, height: 50, alignment: .center)
                
                Image("chevron-right").resizable().frame(width: 10, height: 20, alignment: .center).foregroundColor(.podpocketGreenColor)
            }
            if let text = text {
                Text(text).foregroundColor(.podpocketGreenColor).font(.subheadline)
            }
            
            
        }
        
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView(text: "Dene")
    }
}
