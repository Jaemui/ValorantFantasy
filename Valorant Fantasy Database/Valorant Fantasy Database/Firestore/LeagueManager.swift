//
//  LeagueManager.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 11/15/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class LeagueManager{
    
    static let shared = LeagueManager()
    private init() {}
    
    private let leagueCollection = Firestore.firestore().collection("leagues");
    
    private func leagueDocument(leagueId: String) -> DocumentReference {
        leagueCollection.document(leagueId);
    }
    //automatically encodes given the encoding init in DatabaseModels
    func createNewLeague(league: League) async throws {
        var tempLeague = league
        tempLeague.leagueId = leagueCollection.document().documentID
        try leagueDocument(leagueId: tempLeague.leagueId ?? "").setData(from: league, merge: false)
        print("League registration successful: \(tempLeague)")
    }
    //automitcally decodes given the decoding init in DatabaseModels
    func getLeague(leagueId: String) async throws -> League{
        try await leagueDocument(leagueId: leagueId).getDocument(as: League.self)
    }
}
