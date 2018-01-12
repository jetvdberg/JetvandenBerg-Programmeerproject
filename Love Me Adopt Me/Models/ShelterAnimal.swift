//
//  ShelterAnimal.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import Foundation
import UIKit

struct ShelterAnimal: Codable {
    
    var age: String
    var animal_breed: String
    var animal_color: String
    var animal_gender: String
    var animal_id: String
    var animal_type: String
    var city: String
    var current_location: String
    var image: URL
    var link: URL
    
    enum CodingKeys: String, CodingKey {
        case age
        case animal_breed
        case animal_color
        case animal_gender
        case animal_id
        case animal_type
        case city
        case current_location
        case image
        case link
    }
}

struct ShelterAnimals: Codable {
    let results: [ShelterAnimal]
}
