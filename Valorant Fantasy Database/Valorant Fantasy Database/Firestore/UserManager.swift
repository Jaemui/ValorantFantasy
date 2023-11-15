//
//  UserManager.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/15/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


final class UserManager{
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users");
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId);
    }
    //automatically encodes given the encoding init in DatabaseModels
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    //automitcally decodes given the decoding init in DatabaseModels 
    func getUser(userId: String) async throws -> DBUser{
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    func updateUserPremiumStatus(userId: String, premium: Bool) async throws{
        let data: [String:Any] = [
            //gives you the raw value which is dynamically set in DatabaseMdoels->DBUser
            DBUser.CodingKeys.premium.rawValue: premium
        ]
        try await userDocument(userId: userId).updateData(data)
    }
}
