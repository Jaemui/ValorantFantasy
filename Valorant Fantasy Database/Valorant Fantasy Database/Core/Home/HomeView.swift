//
//  HomeView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/17/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        let user = viewModel.user
        VStack{
            NavigationLink(
                destination: LeagueRegistrationView(),
                label: {
                    Text("Create a League")
                }
            )
            NavigationLink(
                destination: HomeView(showSignInView: $showSignInView),
                label: {
                    Text("Join a League")
                }
            )
            NavigationLink(
                destination: UserLeaguesView(),
                label:{
                    Text("Your Leagues")
                }
            )
            
            NavigationLink(
                destination: ProfileView(showSignInView: $showSignInView),
                label:{
                    Text("Profile View")
                }
            )
        }
        .navigationTitle("Welcome \(user?.username ?? "default")")
        .task{
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView(showSignInView: .constant(false))
        }
    }
}
