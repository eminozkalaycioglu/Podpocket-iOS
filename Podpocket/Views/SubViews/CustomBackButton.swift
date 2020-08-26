//
//  CustomBackButton.swift
//  Podpocket
//
//  Created by Emin on 26.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("back")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                    .frame(width: 25, height: 25, alignment: .center)
                Text("Go back")
                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
            }
        }
    }
}