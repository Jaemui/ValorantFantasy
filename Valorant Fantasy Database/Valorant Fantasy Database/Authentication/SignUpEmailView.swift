//
//  SignInEmailView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/3/23.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pawword found.")
            return
        }
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}
struct SignUpEmailView: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    @Binding var showSignInView: Bool
    @State private var isSignUpSuccessful = false

    
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
                            try await viewModel.signUp()
                            isSignUpSuccessful = true
                        }
                        catch{
                            print(error)
                        }
                    }
                }label:{
                    Text("Sign up")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                NavigationLink(destination: UserRegistrationView(showSignInView: $showSignInView),
                    isActive: $isSignUpSuccessful,
                    label: {
                            EmptyView()
                        }
                    )
            }
        }
    }
}

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpEmailView(showSignInView: .constant(false))
    }
}
