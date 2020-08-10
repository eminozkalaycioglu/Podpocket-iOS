//
//  LoginView.swift
//  Podpocket
//
//  Created by Emin on 28.07.2020.
//  Copyright © 2020 Emin. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @State var mail: String = ""
    @State var pass: String = ""
    @State var presentSignup: Bool = false
    
    var body: some View {
        ZStack {
            Image("LoginBG")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Image("Logo")
                    Text("POD\nCASTR")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding()
                }.padding(.bottom, 50)
                
                
                VStack {
                    
                    
                    HStack {
                        Text("LOGIN")
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.horizontal, 30)
                    
                    
                    
                    CustomTextField(placeholder: Text("E-mail:").foregroundColor(.gray), text: self.$mail)
                        .foregroundColor(.white)

                        .padding()
                        .background(Color.init(.darkGray).opacity(0.2))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    
                    
                    CustomSecureField(placeholder: Text("Password:").foregroundColor(.gray), text: self.$pass)
                        .foregroundColor(.white)
                        .textContentType(.password)
                        .padding()
                        .background(Color.init(.darkGray).opacity(0.2))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    
                    
                    Button(action: {
                        self.viewModel.login(email: self.mail, password: self.pass)
                    }) {
                        
                        ZStack {
                            Circle().stroke(Color.white.opacity(0.3), lineWidth: 1).frame(width: 50, height: 50, alignment: .center)
                            
                            Image("chevron-right").resizable().frame(width: 10, height: 20, alignment: .center).foregroundColor(Color.init(hex: "#50E3C2"))
                        }
                        
                    }.padding(.vertical, 30)
                    
                    
                    Button(action: {
                        self.presentSignup = true
                    }) {
                        Text("SIGN UP")
                            .foregroundColor(.white).opacity(0.3)
                    }
                    
                    
                    
                    
                    
                }
                
                
            }
            
            NavigationLink(destination: SignUpView(), isActive: self.$presentSignup) {
                Text("")
            }
            
            
            NavigationLink(destination: ContentView(), isActive: self.$viewModel.presentHomePage) {
                Text("")
            }
        }.navigationBarTitle("").navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
