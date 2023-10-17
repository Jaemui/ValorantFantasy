//
//  ProfileView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/15/23.
//

import SwiftUI
@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws{
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser();
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
}


struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List{
            if let user = viewModel.user {
                Text("UserId: \(user.userId)");
                Text("Email: \(user.email ?? "default")")
            }
        }
        .task{
            try? await viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink{
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName:"gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ProfileView(showSignInView: .constant(false))
        }
    }
}