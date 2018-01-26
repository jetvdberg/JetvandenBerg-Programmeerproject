//
//  LoveMeViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//


import UIKit
import Foundation

class LoveMeViewController: UIViewController {
    var animalTypes = ["Dogs", "Cats", "Birds", "Remaining Animal Types"]

    let animalController = AnimalController()
    var shelterAnimals = [ShelterAnimal]()
    var shelterAnimal: ShelterAnimal!
    
    var shelterDogs = [ShelterAnimal]()
    var shelterCats = [ShelterAnimal]()
    var shelterBirds = [ShelterAnimal]()
    var remaining = [ShelterAnimal]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimalController.shared.fetchAnimals { (shelterAnimals) in
            if let shelterAnimals = shelterAnimals {
                self.updateUI(with: shelterAnimals)
                self.filterAnimals(with: shelterAnimals)
            }
        }
    }
    
    // Updates scene
    func updateUI(with shelterDogs: [ShelterAnimal]) {
        DispatchQueue.main.async {
            self.shelterAnimals = shelterDogs
            self.tableView.reloadData()
        }
    }
    
    func filterAnimals(with shelterAnimals: [ShelterAnimal]) {
        shelterAnimals.forEach { ShelterAnimal in
            
            let animalType: String? = ShelterAnimal.animal_type
            if let someAnimalType = animalType {
                switch someAnimalType {
                case "Dog":
                    shelterDogs.append(ShelterAnimal)
                case "Cat":
                    shelterCats.append(ShelterAnimal)
                case "Bird":
                    shelterBirds.append(ShelterAnimal)
                default:
                    remaining.append(ShelterAnimal)
                }
            } else {
                return
            }
        }
    }
    
}

extension LoveMeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalTypes[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return animalTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! subClass
        switch indexPath {
        case [0,0]:
            cell.shelterAnimals = self.shelterDogs
            cell.collectionView.reloadData()
            print(shelterDogs.count)
        case [1,0]:
            cell.shelterAnimals = self.shelterCats
            cell.collectionView.reloadData()
            print(shelterCats.count)
        case [2,0]:
            cell.shelterAnimals = self.shelterBirds
            cell.collectionView.reloadData()
            print(shelterBirds.count)
        default:
            cell.shelterAnimals = self.remaining
            cell.collectionView.reloadData()
            print(remaining.count)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178.0
    }

    // MARK: - Navigation
    
    // Segue for EventDetailSegue with details of certain event
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoveMeSegue" {
            let detailsLoveMeViewController = segue.destination as! DetailsLoveMeViewController
            let selectedCell = sender as! AnimalCollectionViewCell
            detailsLoveMeViewController.shelterAnimal = selectedCell.shelterAnimal
        }
    }
    
}
