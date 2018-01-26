//
//  Dog.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 26-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import Foundation

struct Dog : Codable {
    let id : String?
    let url : String?
    let time : String?
    let format : String?
    let verified : Int?
    let checked : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case url = "url"
        case time = "time"
        case format = "format"
        case verified = "verified"
        case checked = "checked"
    }
}

// Struct to filter out the "results" in JSON-object
struct Dogs: Codable {
    let results: [Dog]
}

