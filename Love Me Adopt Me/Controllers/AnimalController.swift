//
//  AnimalController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit

class AnimalController {
    
    let animalURL = URL(string: "https://data.kingcounty.gov/resource/murn-chih.json")!
    
    // Get data from API via URL, with filtering "results" due to JSONDecoder
    func fetchAnimals(completion: @escaping ([ShelterAnimal]?) -> Void) {
        let task = URLSession.shared.dataTask(with: animalURL) { (data, response, error) in
            
            // Parsing data with JSONDecoder
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let shelterAnimals = try? jsonDecoder.decode(ShelterAnimals.self, from: data) {
                completion(shelterAnimals.results)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                completion(nil)
            }
        }
        task.resume()
    }
}
