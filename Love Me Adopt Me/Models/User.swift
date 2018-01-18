//
//  User.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 17-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import Foundation

// Struct representing User, with email and password
struct User {
    
    // Properties
    let uid: String
    let email: String
    
    // Initialize properties for Firebase
    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }
    
    // Initialize properties
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
