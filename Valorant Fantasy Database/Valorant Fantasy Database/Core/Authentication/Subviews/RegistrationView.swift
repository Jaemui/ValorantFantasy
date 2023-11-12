//
//  RegistrationView.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/25/23.
//

import SwiftUI

struct RegistrationView: View{
    @StateObject private var viewModel = SignUpEmailViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationView {
            SignUpEmailView(showSignInView: $showSignInView)
                .environmentObject(viewModel) // Pass the view model to child views
            }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(showSignInView: .constant(false))
    }
}
