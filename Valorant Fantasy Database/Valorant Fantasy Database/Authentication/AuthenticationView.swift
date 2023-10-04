//
//  AuthenticationView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/3/23.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                VStack{
                    Image("app name")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    NavigationLink {
                        SignInEmailView()
                    } label:{
                        Text("Sign in With Email")
                            .foregroundColor(.white)
                            .frame(width:300, height:50)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
