//
//  SignInEmailView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/4/23.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    //IMPORTANT COME BACK TO THIS AND FIX VALIDATION!!!!!!
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pawword found.")
            return
        }
        //come back and make a separate viewModel for these signIn functions
        let authDataResult = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
}
struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
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
                    Task{
                        do{
                            try await viewModel.signIn()
                            showSignInView = false
                        }
                        catch{
                            print(error)
                        }
                    }
                }label:{
                    Text("Sign In")
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
        SignInEmailView(showSignInView: .constant(false))
    }
}
