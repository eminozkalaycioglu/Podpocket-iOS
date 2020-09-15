//
//  EditProfileView.swift
//  Podpocket
//
//  Created by Emin on 12.08.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var viewModel = EditProfileViewModel()
    
    @State var birthday: Date = Date()
    @State var errorMessage: String = ""
    @State var showErrorAlert: Bool = false
    let rangeDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
    
    var body: some View {
        
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                self.drawCustomTextField(placeholder: "Username: ", text: self.$viewModel.user.username, padding: .horizontal)
                self.drawCustomTextField(placeholder: "E-mail: ", text: self.$viewModel.user.mail, padding: .horizontal)
                
                self.drawCustomTextField(placeholder: "Full name:", text: self.$viewModel.user.fullName, padding: .leading)
                
                DatePicker(selection: self.$birthday, in: ...(self.rangeDate ?? Date()), displayedComponents: .date) {
                    Text("Birthday:").foregroundColor(.gray)
                }
                .frame(height: 20, alignment: .center)
                .padding()
                .background(Color.init(.darkGray).opacity(0.2))
                .cornerRadius(30)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                
                
                Button(action: {
                    let df = DateFormatter()
                    df.dateFormat = "dd/MM/yyyy"
                    let dateString = df.string(from: self.birthday)
                    
                    self.viewModel.user.birthday = dateString
                    
                    self.viewModel.edit { error, emailChanged in
                        
                        
                        if let error = error {
                            self.errorMessage = error
                            self.showErrorAlert = true
                        }
                        else {
                            if emailChanged {
                                _ = self.viewModel.signOut()
                            }
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }
                    }
                    
                }) {
                    SaveButtonView(text: "Update")

                }.padding(.vertical, 30)
                
            }
            
        }
        .onAppear {
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy"
            
            self.birthday = df.date(from: self.viewModel.user.birthday) ?? Date()
        }
        .alert(isPresented: self.$showErrorAlert, content: {
            Alert(title: Text("Error"), message: Text(self.errorMessage), dismissButton: .default(Text("Try Again")))
        })
        
        
    }
    
    func drawCustomTextField(placeholder: String, text: Binding<String>, padding: Edge.Set) -> AnyView {
        return AnyView(
            CustomTextField(placeholder: Text(placeholder).foregroundColor(.gray), text: text)
                .foregroundColor(.white)
                .padding()
                .background(Color.init(.darkGray).opacity(0.2))
                .cornerRadius(30)
                .padding(padding)
                .padding(.bottom, 10)
            
        )
        
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
