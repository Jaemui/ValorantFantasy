////
////  LeagueRegistrationView.swift
////  Valorant Fantasy Database
////
////  Created by Joshua Tran on 11/15/23.
////
//
import SwiftUI

@MainActor
final class LeagueRegistrationViewModel: ObservableObject{
    
    @Published var leagueId = "";
    @Published var leagueName = "";
    @Published var host: DBUser = DBUser();
    @Published var users: [DBUser]? = nil;
    @Published var dateCreated = Date.now;

    func register() async throws{
        guard !leagueName.isEmpty else{
            return;
        }
        //get current user as an Authenticated User
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser();
        print("Authenticated user: \(authDataResult)")
        //get DBUser given the AuthDataResult
        self.host = try await UserManager.shared.getUser(userId: authDataResult.uid)
        print("User retrieved: \(self.host)")
        let league = League(leagueId: leagueId, leagueName: leagueName,
                            host: host, users: users, dateCreated: dateCreated)
        try await LeagueManager.shared.createNewLeague(league: league)
    }
}
struct LeagueRegistrationView: View {
    @StateObject private var viewModel = LeagueRegistrationViewModel()
    @State private var isRegistrationSuccessful = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                Image("Create A League")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                TextField("Enter League Name", text: $viewModel.leagueName)
                    .padding()
                    .frame(width:300, height:50)
                    .background(Color.gray.opacity(0.9))
                    .cornerRadius(10)
                
                Button{
                    Task{
                        do{
                            try await viewModel.register()
                            isRegistrationSuccessful = true;
                        }
                        catch{
                            
                        }
                    }
                }label:{
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(width:300, height:50)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                NavigationLink(
                    destination: UserLeaguesView(),
                    isActive: $isRegistrationSuccessful,
                    label: {
                            EmptyView()
                        }
                    )
                .padding()
            }
        }
    }
}

struct LeagueRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueRegistrationView()
    }
}
