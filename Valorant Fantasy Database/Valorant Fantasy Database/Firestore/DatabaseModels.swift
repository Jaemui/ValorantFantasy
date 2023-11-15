//
//  DatabaseModels.swift
//  Valorant Fantasy Database
//
//  Created by Joshua Tran on 11/13/23.
//

import Foundation

//User
struct DBUser: Codable{
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let username: String?
    let birthdate: Date?
//    let leagues: [League]?
    let premium: Bool?
    init(auth: AuthDataResultModel, username: String, birthdate: Date){
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.username = username
        self.birthdate = birthdate
        self.premium = false
    }
    init(
        userId: String,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        username: String? = nil,
        birthdate: Date? = nil,
        premium: Bool? = false)
    {
        self.userId =  userId
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.username = username
        self.birthdate = birthdate
        self.premium = premium 
                
    }
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case username = "username"
        case birthdate = "birthdate"
        case premium = "premium"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.birthdate = try container.decodeIfPresent(Date.self, forKey: .birthdate)
        self.premium = try container.decodeIfPresent(Bool.self, forKey: .premium)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.username, forKey: .username)
        try container.encodeIfPresent(self.birthdate, forKey: .birthdate)
        try container.encodeIfPresent(self.premium, forKey: .premium)
    }
}

//struct League: Codable{
//    let leagueId: String
//    let leagueName: String
//    let host: DBUser
//    let users: [DBUser]?
//    let dateCreated: Date?
//    let tournament: Tournament
//}
//
//struct Tournament: Codable{
//    let tournamentId: String
//    let tournamentName: String
//    let dateStart: Date
//    let dateEnd: Date
//    let region: String
//    let matches: [Match]
//}
//
//struct Match: Codable{
//    let matchId: String
//    let team1: Team
//    let team2: Team
//    let team1Score: Int
//    let team2Score: Int
//    let mapData: [Map]
//}
//
//struct Team: Codable{
//    let teamId: String
//    let teamName: String
//    let teamAcr: String
//}
//
//struct Map: Codable{
//    let mapId: String
//    let mapName: String
//    let team1Score: Int
//    let team2Score: Int
//    
//}
