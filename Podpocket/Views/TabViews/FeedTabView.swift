//
//  FeedTabView.swift
//  Podpocket
//
//  Created by Emin on 10.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct FeedTabView: View {
    
    @ObservedObject var viewModel = FeedTabViewModel()
    
    @State var showMore = false
    
    
    @State var writing = false
    @State var test2 = ""
    var longMessage = "You want to round the corners of your border, you need to use the overlay() modifier instead. For example, this adds a 4-point blue border with 16-point rounded corners: You want to round the corners of your border, you need to use the overlay() modifier instead. For example, this adds a 4-point blue border with 16-point rounded corners: You want to round the corners of your border, you need to use the overlay() modifier instead. For example, this adds a 4-point blue border with 16-point rounded corners: You want to round the corners of your border, you need to use the overlay() modifier instead. For example, this adds a 4-point blue border with 16-point rounded corners:"
    var shortMessage = "Message"
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                Color.init(hex: Color.podpocketPurpleColor)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture{
                        withAnimation {
                            self.writing = false
                        }
                        
                    }
                VStack {
                    ScrollView(.vertical) {
                        LazyVGrid(columns: [GridItem(.flexible(minimum: 0, maximum: .infinity))], content: {
                            ForEach(0..<20) { index in
                                FeedCell(writing: self.$writing, message: index%2 == 0 ? self.longMessage : self.shortMessage)

                            }
                        })
                    }
                }.onTapGesture {
                    withAnimation {
                        self.writing = false
                    }
                }
                if !self.writing {
                    
                    Button(action: {
                        withAnimation {
                            self.writing.toggle()
                        }
                    }, label: {
                        Image("share")
                            .resizable()
                            .frame(width: geometry.size.width/7, height: geometry.size.width/7)
                    }).padding()
                    
                } else {
                    
                    VStack {
                        MultilineTextField("What's going on?", text: self.$test2)
                            .padding()
                            .background(Color.init(hex: Color.podpocketPurpleColor).opacity(0.8))

                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.init(hex: Color.podpocketGreenColor), lineWidth: 2)
                            )
                            .shadow(radius: 10)
                            .padding()
                        
                        Button(action: {
                            self.viewModel.share(message: self.test2)
                            
                        }, label: {
                            HStack {
                                Spacer()
                                Text("SHARE")
                                    .font(.title2)
                                    .foregroundColor(Color.init(hex: Color.podpocketGreenColor))
                                Spacer()
                            }
                            .padding(5)
                            .background(Color.init(hex: Color.podpocketPurpleColor))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.init(hex: Color.podpocketGreenColor), lineWidth: 2)
                            )
                            .shadow(radius: 10)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        })
                    }
                    
                    

                    
                }
                
                
            }.navigationBarTitle("").navigationBarHidden(true)
            .onReceive(self.viewModel.$success, perform: { _ in
                if self.viewModel.success {
                    self.writing = false
                }
            })
        }
    }
}


struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.textColor = UIColor().hexStringToUIColor(hex: Color.podpocketGreenColor).withAlphaComponent(0.8)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
        
        
    }
}

@available(iOS 14.0, *)
struct FeedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTabView()
    }
}
