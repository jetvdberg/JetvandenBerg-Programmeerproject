//
//  ShelterAnimal.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This struct holds the properties of each shelter animal, parsed from the API. This data is used throughout the app.
//

import Foundation
import UIKit

// Struct representing details of each shelter animal
struct ShelterAnimal {
    
    var age: String?
    var animal_breed: String?
    var animal_color: String?
    var animal_gender: String?
    var animal_id: String?
    var animal_name : String?
    var animal_type: String?
    var city: String?
    var current_location: String?
    var image: URL?
    var link: URL?
    var memo: String?
    
    init() { }
}


