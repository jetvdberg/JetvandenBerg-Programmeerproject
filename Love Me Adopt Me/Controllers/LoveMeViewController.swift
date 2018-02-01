//
//  LoveMeViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class creates a CollectionView in a TableView, which displays all the shelter animals from the API. For each animal type is a separate array and section created. Each cell holds a shelter animal, based on the animal type (and section). The user can tap an animal, and will be navigated to another view.
//

import UIKit
import Foundation

class LoveMeViewController: UIViewController {
    
    // Properties
    var animalTypes = ["Dogs", "Cats", "Birds"]
    let animalController = AnimalController()
    var shelterAnimals = [ShelterAnimal]()
    var shelterAnimal: ShelterAnimal!
    
    var shelterDogs = [ShelterAnimal]()
    var shelterCats = [ShelterAnimal]()
    var shelterBirds = [ShelterAnimal]()
    var remaining = [ShelterAnimal]()
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // Loads view
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        // Checks if shelterAnimals exist, performs functions
        AnimalController.shared.fetchAnimals { (shelterAnimals) in
            if let shelterAnimals = shelterAnimals {
                self.updateUI(with: shelterAnimals)
                self.filterAnimals(with: shelterAnimals)
            }
        }
    }
    
    // Updates scene
    func updateUI(with shelterAnimals: [ShelterAnimal]) {
        DispatchQueue.main.async {
            self.shelterAnimals = shelterAnimals
            self.tableView.reloadData()
        }
    }
    
    // Filters shelterAnimals, adds different animal types to corresponding arrays
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
            } else { return }
        }
    }
    
}

// Extension of LoveMeViewController: manages the TableView settings and data
extension LoveMeViewController : UITableViewDelegate, UITableViewDataSource {
    
    // Sets titles for headers in TableView
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalTypes[section]
    }
    
    // Returns number of sections in TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return animalTypes.count
    }
    
    // Returns number of rows in TableViewSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Defines cell, fills in animal data for corresponding cell in TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! subClass
        
        // Checks for each section which array is needed
        switch indexPath {
        case [0,0]:
            cell.shelterAnimals = self.shelterDogs
            cell.collectionView.reloadData()
        case [1,0]:
            cell.shelterAnimals = self.shelterCats
            cell.collectionView.reloadData()
        case [2,0]:
            cell.shelterAnimals = self.shelterBirds
            cell.collectionView.reloadData()
        default:
            cell.collectionView.reloadData()
        }
        return cell
    }

    // Returns height of TableViewRow
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    // MARK: - Navigation
    
    // Performs segue to DetailsLoveMeViewController, sends corresponding data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoveMeSegue" {
            let detailsLoveMeViewController = segue.destination as! DetailsLoveMeViewController
            let selectedCell = sender as! AnimalCollectionViewCell
            detailsLoveMeViewController.shelterAnimal = selectedCell.shelterAnimal
        }
    }
    
}
