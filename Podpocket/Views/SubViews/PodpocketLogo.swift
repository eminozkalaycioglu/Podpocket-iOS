//
//  PodpocketLogo.swift
//  Podpocket
//
//  Created by Emin on 26.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct PodpocketLogo: View {
    var body: some View {
        HStack {
            Image("Logo")
            Text("Podpocket")
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct PodpocketLogo_Previews: PreviewProvider {
    static var previews: some View {
        PodpocketLogo()
    }
}
