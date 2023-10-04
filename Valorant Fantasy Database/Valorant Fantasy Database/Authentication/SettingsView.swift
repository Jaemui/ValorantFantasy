//
//  SettingsView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/3/23.
//

import SwiftUI
@MainActor
final class SettingsViewModel: ObservableObject{
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}
struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log Out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    } catch{
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}
