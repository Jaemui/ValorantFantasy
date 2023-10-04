//
//  SignInEmailView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/3/23.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn(){
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pawword found.")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print (returnedUserData)
            }
            catch{
                print("Error: \(error)")
            }
        }
    }
    
    
}
struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Image("app name")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.gray.opacity(0.9))
                    .cornerRadius(10)
//                    .border(.red, width:CGFloat(wrongUsername))
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.gray.opacity(1.0))
                    .cornerRadius(10)
//                    .border(.red, width:CGFloat(wrongPassword))
                Button{
                    viewModel.signIn()
                }label:{
                    Text("Sign in")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignInEmailView()
    }
}
