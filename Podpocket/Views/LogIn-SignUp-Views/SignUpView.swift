//
//  SignUpView.swift
//  Podpocket
//
//  Created by Emin on 28.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI
struct SignUpView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    @State var fullName: String = ""
    @State var mail: String = ""
    @State var pass: String = ""
    @State var username: String = ""
    @State var presentLogin: Bool = false
    @State var presentHomePage: Bool = false
    @State var birthday: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    @State var showErrorAlert: Bool = false
    @State var errorMessage: String = ""
    let rangeDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
    
    
    var body: some View {
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                PodpocketLogo()
                    .padding(.bottom, 50)
                
                
                VStack {
                    
                    
                    HStack {
                        Text("SIGN UP")
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal, 30)
                    
                    self.drawCustomTextField(placeholder: "Username: ", text: self.$username, padding: .horizontal)
                    self.drawCustomTextField(placeholder: "E-mail: ", text: self.$mail, padding: .horizontal)
                    
                    
                    CustomSecureField(placeholder: Text("Password:").foregroundColor(.gray), text: self.$pass)
                        .foregroundColor(.white)
                        .textContentType(.password)
                        .padding()
                        .background(Color.init(.darkGray).opacity(0.2))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    HStack {
                        
                        self.drawCustomTextField(placeholder: "Full name:", text: self.$fullName, padding: .leading)
                        
                        
                        DatePicker(selection: self.$birthday, in: ...(self.rangeDate ?? Date()), displayedComponents: .date) {
                            Text("Birthday:").foregroundColor(.gray)
                        }
                        .frame(width: 180, height: 20, alignment: .center)
                        .padding()
                        .background(Color.init(.darkGray).opacity(0.2))
                        .cornerRadius(30)
                        .padding(.trailing)
                        .padding(.bottom, 10)
                        
                        
                    }
                    
                    
                    Button(action: {
                        let df = DateFormatter()
                        df.dateFormat = "dd/MM/yyyy"
                        let dateString = df.string(from: self.birthday)
                        
                        
                        self.viewModel.signUp(email: self.mail, password: self.pass, fullName: self.fullName, username: self.username, birthday: dateString) { (errorStr) in
                            
                            
                            if let errorString = errorStr {
                                self.errorMessage = errorString as String
                                self.showErrorAlert = true
                            }
//                            if errorStr != nil {
//
//
//                                self.errorMessage = errorStr! as String
//                                self.showErrorAlert = true
//
//                            }
                        }
                        
                        
                    }) {
                        
                        SaveButtonView()
                        
                    }.padding(.vertical, 30)
                    
                    
                    Button(action: {
                        self.presentLogin = true
                    }) {
                        Text("LOGIN")
                            .foregroundColor(.white).opacity(0.3)
                    }
                    
                    
                    
                }
                
                
            }
            
            NavigationLink(destination: LoginView(), isActive: self.$presentLogin) {
                Text("")
            }
            
            
            NavigationLink(destination: ContentView(), isActive: (self.$viewModel.presentHomePage)) {
                Text("")
            }
        }.navigationBarTitle("").navigationBarHidden(true)
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
