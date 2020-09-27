//
//  GenreCell.swift
//  Podpocket
//
//  Created by Emin on 28.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct GenreCell: View {
    var genre: Genre
    
    
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.genre.name ?? "Noname")
                    .font(.system(size: 12))
                    .foregroundColor(self.isSelected ? Color.podpocketGreenColor : .gray)
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(self.isSelected ? Color.podpocketGreenColor : Color.gray, lineWidth: 0.5))
            }
        }
    }
}

struct GenreCell_Previews: PreviewProvider {
    static var previews: some View {
        
        GenreCell(genre: Genre(id: 1, name: "Web Design", parentId: 21), isSelected: true, action: {
            
        })
    }
}
