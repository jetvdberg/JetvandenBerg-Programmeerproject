//
//  DetailsUserTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class holds the list of another user, which is stored in Firebase. The user can view this list and, when navigating back, the account of this recently viewed list, will appear at the top of recently viewed users.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DetailsUsersTableViewController: UITableViewController {
    
    // Properties
    var shelterAnimals = [ShelterAnimal]()
    var myLovesList = [LovesModel]()
    var user: User!
    var dataRef = Database.database().reference()
    
    // Outlet
    @IBOutlet weak var userEmailLabel: UILabel!
    
    // Loads view, updates label viewed user
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailLabel.text = user.email
        
        // Checks for existing data in Firebase
        dataRef.child("lists-of-users").child(user.uid).observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            self.myLovesList = []
            
            // Iterates over data existing in snapshot Firebase, checks for value
            for animals in snapshot.children.allObjects as! [DataSnapshot] {
                let animalObject = animals.value as? [String: AnyObject]
                let ID = animalObject?["id"]
                let animal_age = animalObject?["animal_age"]
                let animal_breed = animalObject?["animal_breed"]
                let animal_color = animalObject?["animal_color"]
                let animal_gender = animalObject?["animal_gender"]
                let animal_id = animalObject?["animal_id"]
                let animal_name = animalObject?["animal_name"]
                let animal_type = animalObject?["animal_type"]
                let city = animalObject?["city"]
                let current_location = animalObject?["current_location"]
                let image = animalObject?["image"]
                let link = animalObject?["link"]
                let memo = animalObject?["memo"]
                
                // Creates instance from LovesModel, creating new animal
                let animal = LovesModel(id: ID as! String?, animal_age: animal_age as! String?, animal_breed: animal_breed as! String?, animal_color: animal_color as! String?, animal_gender: animal_gender as! String?, animal_id: animal_id as! String?, animal_name: animal_name as! String?, animal_type: animal_type as! String?, city: city as! String?, current_location: current_location as! String?, image: image as! String?, link: link as! String?, memo: memo as! String?)
                
                // Adds animal to list
                self.myLovesList.append(animal)
                self.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source

    // Returns number of rows in TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLovesList.count
    }

    // Returns cell with configured data in TableViewRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }

    // Configures cell and fills up each cell and label with corresponding data
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let shelterAnimal = myLovesList[indexPath.row]
        cell.textLabel?.text = (shelterAnimal.animal_name != nil) ? shelterAnimal.animal_name : "nameless :("
        cell.detailTextLabel?.text = (shelterAnimal.animal_breed != nil) ? shelterAnimal.animal_breed : "Unknown"
        
        // Checks if image exists, fills with image
        let imageURL = URL(string: shelterAnimal.image!)
        AnimalController.shared.fetchImage(url: imageURL!)
        { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
    }
    
}
