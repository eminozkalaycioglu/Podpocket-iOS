//
//  TestView.swift
//  Podpocket
//
//  Created by Emin on 28.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TestView: View {
    @State var items: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos", "Grapefruit"]
        @State var selections: [String] = []

        var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(10))], spacing: 20) {
                    ForEach(self.items, id: \.self) { item in
                        MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
                            if self.selections.contains(item) {
                                self.selections.removeAll(where: { $0 == item })
                            }
                            else {
                                self.selections.append(item)
                            }
                        }
                    }
                }
            }
        }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                    .foregroundColor(self.isSelected ? Color.init(hex: Color.podpocketGreenColor) : .gray)
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(self.isSelected ? Color.init(hex: Color.podpocketGreenColor) : Color.gray))
//                if self.isSelected {
//                    Spacer()
//                    Image(systemName: "checkmark")
//                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            TestView()
        } else {
            // Fallback on earlier versions
        }
    }
}
