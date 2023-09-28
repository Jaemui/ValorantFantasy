//
//  LogIn.swift
//  ValFantasy
//
//  Created by Joshua Tran on 9/20/23.
//

import SwiftUI

struct LogIn: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Image("app name")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.gray.opacity(0.9))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongUsername))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.gray.opacity(1.0))
                        .cornerRadius(10)
                        .border(.red, width:CGFloat(wrongPassword))
                    Button("Login"){
                        //Authenticate user
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.red)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in @\(username)"), isActive:$showingLoginScreen) {
                        EmptyView()
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
