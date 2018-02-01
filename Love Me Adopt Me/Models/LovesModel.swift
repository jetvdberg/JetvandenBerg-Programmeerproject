//
//  LovesModel.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 24-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class holds the properties of each shelter animal, read/written from Firebase. This data is used throughout the app.
//

import UIKit
import Foundation

// Class each shelter animal, for reading and writing data to Firebase
class LovesModel {
    
    // Properties
    var id: String?
    var animal_age: String?
    var animal_breed: String?
    var animal_color: String?
    var animal_gender: String?
    var animal_id: String?
    var animal_name : String?
    var animal_type: String?
    var city: String?
    var current_location: String?
    var image: String?
    var link: String?
    var memo: String?
    
    // Initialize properties
    init(id: String?, animal_age: String?, animal_breed: String?, animal_color: String?, animal_gender: String?, animal_id: String?, animal_name: String?, animal_type: String?, city: String?, current_location: String?, image: String?, link: String?, memo: String?) {
        self.id = id
        self.animal_age = animal_age
        self.animal_breed = animal_breed
        self.animal_color = animal_color
        self.animal_gender = animal_gender
        self.animal_id = animal_id
        self.animal_name = animal_name
        self.animal_type = animal_type
        self.city = city
        self.current_location = current_location
        self.image = image
        self.link = link
        self.memo = memo
    }
}

