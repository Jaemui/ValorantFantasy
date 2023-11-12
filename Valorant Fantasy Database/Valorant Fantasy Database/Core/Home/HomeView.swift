//
//  HomeView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/17/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        let user = viewModel.user
        VStack{
            NavigationLink{
                
            }
            label: {
                Text("Create a League")
            }
            NavigationLink{
                
            }
            label: {
                Text("Join a League")
            }
            NavigationLink{
                
            }
            label:{
                Text("Your Leagues")
            }
        }
        .navigationTitle("Welcome \(user?.username ?? "default")")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
        }
    }
}
