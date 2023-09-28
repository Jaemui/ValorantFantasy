//
//  User.swift
//  Valorant Fantasy Official
//
//  Created by Joshua Tran on 9/27/23.
//

import Foundation
class User {
    var username: String
    var email: String
    private var password: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    func getUserName()->String{
        return username;
    }
    
    func getEmail()->String{
        return email
    }
}
