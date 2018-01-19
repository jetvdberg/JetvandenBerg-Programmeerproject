//
//  AnimalController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import Foundation

class AnimalController {
    static let shared = AnimalController()
    
    let animalURL = URL(string: "https://data.kingcounty.gov/resource/murn-chih.json")!
    
    // Get data from API via URL, with filtering "results" due to JSONDecoder
    func fetchAnimals(completion: @escaping ([ShelterAnimal]?) -> Void) {
        let task = URLSession.shared.dataTask(with: animalURL) { (data, response, error) in
            
            var json: [AnyObject]?
            var animal = [ShelterAnimal]()
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
                    temp.image = shelterAnimal!["image"] as? URL
                    temp.link = shelterAnimal!["link"] as? URL
                    
                    animal.append(temp)
                }
            completion(animal)
            print(animal)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
