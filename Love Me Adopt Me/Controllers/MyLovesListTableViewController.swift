//
//  MyLovesListTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class holds all the 'liked' animals of a user. The list is read from/written to Firebase. The user can view the details of a certain animal by selecting the cell, and will be navigated to ContactShelterViewController.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

// Gets data from DetailsLoveMeViewController
protocol AddToMyLovesDelegate {
    func added(shelterAnimal: ShelterAnimal)
}

class MyLovesListTableViewController: UITableViewController, AddToMyLovesDelegate {
    
    // Properties
    var shelterAnimals = [ShelterAnimal]()
    var myLovesList = [LovesModel]()
    var user: User!
    let userID = (Auth.auth().currentUser?.uid)!
    let userEmail = (Auth.auth().currentUser?.email)!
    var dataRef = Database.database().reference()
    
    // Loads view, performs functions
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Checks for existing data in Firebase for current user
        dataRef.child("lists-of-users").child(userID).observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() { return }
            self.myLovesList = []
            
            // Iterates over data existing in snapshot Firebase, checks for value
            for animals in snapshot.children.allObjects as! [DataSnapshot] {
                let animalObject = animals.value as? [String: AnyObject]
                let ID = animalObject?["id"] as! String
                let animal_age = animalObject?["animal_age"] as! String?
                let animal_breed = animalObject?["animal_breed"] as! String?
                let animal_color = animalObject?["animal_color"] as! String?
                let animal_gender = animalObject?["animal_gender"] as! String?
                let animal_id = animalObject?["animal_id"] as! String?
                let animal_name = animalObject?["animal_name"] as! String?
                let animal_type = animalObject?["animal_type"] as! String?
                let city = animalObject?["city"] as! String?
                let current_location = animalObject?["current_location"] as! String?
                let image = animalObject?["image"] as! String?
                let link = animalObject?["link"] as! String?
                let memo = animalObject?["memo"] as! String?
                
                // Creates instance from LovesModel, creating new animal
                let animal = LovesModel(id: ID, animal_age: animal_age, animal_breed: animal_breed, animal_color: animal_color, animal_gender: animal_gender, animal_id: animal_id, animal_name: animal_name, animal_type: animal_type, city: city, current_location: current_location, image: image, link: link, memo: memo)
                
                // Adds animal to list
                self.myLovesList.append(animal)
                self.tableView.reloadData()
            }
            self.updateBadgeNumber()
        })
    }

    // MARK: - Table view data source
    
    // Reloads view
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    // Returns number of rows in TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLovesList.count
    }
    
    // Returns cell with configured data in TableViewRow
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyLoveListCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    // Enables editing rows in TableView
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Enables deleting rows in TableView
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataRef.child("lists-of-users").child(userID).child(myLovesList[indexPath.row].animal_id!).removeValue()
            myLovesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewDidLoad()
            updateBadgeNumber()
        }
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
    
    // Updates badgeNumber
    func added(shelterAnimal: ShelterAnimal) {
        viewDidLoad()
        updateBadgeNumber()
    }
    
    // Updates badgeNumber, representing number of 'Loves' in list
    func updateBadgeNumber() {
        let badgeValue = myLovesList.count > 0 ? "\(myLovesList.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    // MARK: - Navigation
    
    // Performs segue to ContactShelterViewController, sends corresponding data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LovesSegue" {
            let contactShelterViewController = segue.destination as! ContactShelterViewController
            let index = tableView.indexPathForSelectedRow!.row
            contactShelterViewController.LovesList = myLovesList[index]
        }
    }

}
