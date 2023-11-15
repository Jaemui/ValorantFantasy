//
//  SignUpEmailViewModel.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 11/12/23.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var username = "";
    @Published var birthdate = Date.now;
//    @Published var premium = false;
    
    
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("No email or pawword found.")
            return
        }
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult,
                          username: username,
                          birthdate: birthdate)
        try await UserManager.shared.createNewUser(user: user)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}
