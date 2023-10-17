//
//  SettingsViewModel.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/15/23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject{
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}
