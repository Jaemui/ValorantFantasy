//
//  UserManager.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 10/15/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
//struct of database user (add more fields later)
struct DBUser{
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
}


final class UserManager{
    
    static let shared = UserManager()
    private init() {}
    
    //create new user document in collection, only use with SignUpEmailView. remove from SignINEmailView
    func createNewUser(auth: AuthDataResultModel) async throws{
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
        ]
        if let email = auth.email {
            userData["email"] = email
        }
        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    //used to update the user's profile upon creation
    func updateUser(auth: AuthDataResultModel, username: String, birthdate: Date) async throws{
        let userData: [String:Any] = [
            "username": username,
            "birthday": birthdate,
        ]
        try await Firestore.firestore().collection("users").document(auth.uid).updateData(userData)
    }
    
    //add fields that need to be retrieved
    func getUser(userId: String) async throws -> DBUser{
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
    
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated)
        
    }
}
