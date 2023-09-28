//
//  Login.swift
//  Valorant Fantasy Official
//
//  Created by Joshua Tran on 9/27/23.
//

import SwiftUI

struct LogIn: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State var loginVerification = false
    @State private var errorMessage = ""
    @State private var showHomeScreen = false
    
    
    
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
                    NavigationLink(destination: Home(), isActive: $showHomeScreen) {
                        EmptyView()
                    }
                    .navigationBarBackButtonHidden(true)
                    Button("Login"){
                        authenticateUser(username: username, password: password)
                    }
                    .foregroundColor(.white)
                    .frame(width:300, height:50)
                    .background(Color.red)
                    .cornerRadius(10)
                }
            }
            .navigationBarHidden(true)
        }
    }
    func authenticateUser(username: String, password: String){
            if username.lowercased() == "123" {
                wrongUsername = 0
                if password == "123" {
                    wrongPassword = 0
                    loginVerification = true
                    errorMessage = "" // Clear any previous error messages
                    showHomeScreen = true
                } else {
                    wrongPassword = 1
                    errorMessage = "Wrong password. Please try again."
                }
            } else {
                wrongUsername = 1
                errorMessage = "Wrong username. Please try again."
            }
        }
    func getUsername() -> String{
        return username;
    }
    func getPassword() -> String{
        return password;
    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}

