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
struct DBUser: Codable{
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let username: String?
    let birthday: Date?
//    let premium: Bool?
}


final class UserManager{
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users");
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId);
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    
//    create new user document in collection, only use with SignUpEmailView. remove from SignINEmailView
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
        try await userDocument(userId: auth.uid).setData(userData, merge: false)
    }
    
    //used to update the user's profile upon creation
    func updateUser(auth: AuthDataResultModel, username: String, birthdate: Date) async throws{
        let userData: [String:Any] = [
            "username": username,
            "birthday": birthdate,
        ]
        try await userDocument(userId: auth.uid).updateData(userData)
    }
    
    //add fields that need to be retrieved
    func getUser(userId: String) async throws -> DBUser{
        let snapshot = try await userDocument(userId: userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
    
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        let dateCreated = data["date_created"] as? Date
        let username = data["username"] as? String
        let birthday = data["birthday"] as? Date
//        let premium = data["premium"] as? Bool
        
        return DBUser(userId: userId, email: email, photoUrl: photoUrl, dateCreated: dateCreated, username: username, birthday: birthday)
        
    }
}
