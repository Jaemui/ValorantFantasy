//
//  RootView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/3/23.
//

import SwiftUI

struct RootView: View {
    
    @State private var showingSignInvView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                SettingsView(showSignInView: $showingSignInvView)
            }
        }
        .onAppear{
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showingSignInvView = authUser == nil
        }
        .fullScreenCover(isPresented: $showingSignInvView){
            NavigationStack{
                AuthenticationView()
            }
        }
    }
}
    
    struct RootView_Previews: PreviewProvider {
        static var previews: some View {
            RootView()
        }
    }
