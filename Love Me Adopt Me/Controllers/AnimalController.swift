//
//  AnimalController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class parses data from an API about adoptable shelter animals (in the state Washington). When parsed, the data is stored in an array. This array is used throughout the app. Link: https://data.kingcounty.gov/resource/murn-chih.json
//

import UIKit
import Foundation

class AnimalController {
    static let shared = AnimalController()
    
    // API for shelter animals
    let animalURL = URL(string: "https://data.kingcounty.gov/resource/murn-chih.json")!
    
    // Get data from API via URL
    func fetchAnimals(completion: @escaping ([ShelterAnimal]?) -> Void) {
        let task = URLSession.shared.dataTask(with: animalURL) { (data, response, error) in
            
            var json: [AnyObject]?
            var animal = [ShelterAnimal]()
            
            // Parse JSON and read data
            do {
                json = try? JSONSerialization.jsonObject(with: data!) as! [AnyObject]
                for object in json! {
                    var temp = ShelterAnimal()
                    let shelterAnimal = object as? [String: Any]
                    
                    temp.age = shelterAnimal!["age"] as? String
                    temp.animal_breed = shelterAnimal!["animal_breed"] as? String
                    temp.animal_color = shelterAnimal!["animal_color"] as? String
                    temp.animal_gender = shelterAnimal!["animal_gender"] as? String
                    temp.animal_id = shelterAnimal!["animal_id"] as? String
                    temp.animal_name = shelterAnimal!["animal_name"] as? String
                    temp.animal_type = shelterAnimal!["animal_type"] as? String
                    temp.city = shelterAnimal!["city"] as? String
                    temp.current_location = shelterAnimal!["current_location"] as? String
                    if let imageURL = shelterAnimal!["image"] as? String {
                        temp.image = URL(string: imageURL)
                    }
                    if let linkURL = shelterAnimal!["link"] as? String {
                        temp.link = URL(string: linkURL)
                    }
                    
                    // Add object to animal array
                    animal.append(temp)
                }
                completion(animal)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // Get images from API via URL
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}
