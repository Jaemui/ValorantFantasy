//
//  UserRegistrationView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/16/23.
//

import SwiftUI

struct UserRegistrationView: View {
    @Binding var showSignInView: Bool
    @EnvironmentObject var viewModel: SignUpEmailViewModel
    
    let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!;
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Image("app name")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.gray.opacity(0.9))
                    .cornerRadius(10)
                DatePicker("Birthday", selection: $viewModel.birthdate, in: ...MINIMUM_AGE, displayedComponents: [.date])
                    .padding()
                    .tint(Color.red)
                    .frame(width:300, height:50)
                    .background(Color.gray.opacity(0.9))
                    .cornerRadius(10)
                    //filler
                
                    
                Button{
                    Task{
                        do{
//                            try await UserRegister.registerUser()
                            try await viewModel.signUp()
                            showSignInView = false
                        }
                        catch{
                            print(error)
                        }
                    }
                }label:{
                    Text("Register")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
        }
    }
}
//@MainActor
//final class UserRegistrationViewModel: ObservableObject{
//    
//    @Published var username = "";
//    @Published var birthdate = Date.now;
//    
//    func registerUser() async throws{
//        guard !username.isEmpty else{
//            print("No username found")
//            return
//        }
//        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser();
//        try await UserManager.shared.updateUser(auth: authDataResult, username: username, birthdate: birthdate)
//    }
//    
//}

//struct UserRegistrationView: View {
//    @Binding var showSignInView: Bool
//    @StateObject private var UserRegister = UserRegistrationViewModel();
//    
//    let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!;
//    
//    var body: some View {
//        ZStack{
//            Color.black.ignoresSafeArea()
//            VStack{
//                Image("app name")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                TextField("Username", text: $UserRegister.username)
//                    .padding()
//                    .frame(width:300, height:50)
//                    .background(Color.gray.opacity(0.9))
//                    .cornerRadius(10)
//                DatePicker("Birthday", selection: $UserRegister.birthdate, in: ...MINIMUM_AGE, displayedComponents: [.date])
//                    .padding()
//                    .tint(Color.red)
//                    .frame(width:300, height:50)
//                    .background(Color.gray.opacity(0.9))
//                    .cornerRadius(10)
//                    //filler
//                
//                    
//                Button{
//                    Task{
//                        do{
//                            try await UserRegister.registerUser()
//                            showSignInView = false
//                        }
//                        catch{
//                            print(error)
//                        }
//                    }
//                }label:{
//                    Text("Register")
//                        .foregroundColor(.white)
//                        .frame(width:300, height:50)
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//            }
//        }
//    }
//}

struct UserRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        UserRegistrationView(showSignInView: .constant(false))
    }
}
