//
//  MyLovesListTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

protocol AddToMyLovesDelegate {
    func added(shelterAnimal: ShelterAnimal)
}

class MyLovesListTableViewController: UITableViewController, AddToMyLovesDelegate {
    
    let listToUsers = "ListToUsers"
    var shelterAnimals = [ShelterAnimal]()
    var myLovesList = [LovesModel]()
    var user: User!
    
    var dataRef = Database.database().reference(withPath: "loves-of-current-user")
    let usersRef = Database.database().reference(withPath: "online-users")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Checks for existing data in Firebase
        dataRef.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            self.myLovesList = []
//            let animalName = snapshot.childSnapshot(forPath: "animalName").value
            
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
                
                
                let animal = LovesModel(id: ID as! String?, animal_age: animal_age as! String?, animal_breed: animal_breed as! String?, animal_color: animal_color as! String?, animal_gender: animal_gender as! String?, animal_id: animal_id as! String?, animal_name: animal_name as! String?, animal_type: animal_type as! String?, city: city as! String?, current_location: current_location as! String?, image: image as! String?, link: link as! String?, memo: memo as! String?)
                
                // Adds event to list
                self.myLovesList.append(animal)
                self.tableView.reloadData()
            }
            self.updateBadgeNumber()
            
        })
        
        user = User(uid: "testId", email: "person@test.com")
        
        // Authorizes users, checks if they are online/offline
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            let currentUserRef = self.usersRef.child(self.user.uid)
            currentUserRef.setValue(self.user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
    }

    // MARK: - Table view data source

    // Reloads view
//    override func viewDidAppear(_ animated: Bool) {
//        viewDidLoad()
//    }
    // MARK: - Table view data source
    
    // Reloads view
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    // Returns number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLovesList.count
    }
    
    // Returns cell with given data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyLoveListCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    // Enables editing rows
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Enables deleting rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataRef.child(myLovesList[indexPath.row].id!).removeValue()
            myLovesList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewDidLoad()
            updateBadgeNumber()
        }
    }
    
    // Configures cells with animal details
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let shelterAnimal = myLovesList[indexPath.row]
        if shelterAnimal.animal_name != nil {
            cell.textLabel?.text = shelterAnimal.animal_name
        } else {
            cell.textLabel?.text = "nameless :("
            
        }
        cell.detailTextLabel?.text = shelterAnimal.animal_breed
        
        let imageURL = URL(string: shelterAnimal.image!)
        AnimalController.shared.fetchImage(url: imageURL!)
        { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        }
    }
    
    // Counts number of favorites in list
    func added(shelterAnimal: ShelterAnimal) {
        viewDidLoad()
        updateBadgeNumber()
    }
    
    // Updates number representing favorites in list
    func updateBadgeNumber() {
        let badgeValue = myLovesList.count > 0 ? "\(myLovesList.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    // MARK: - Navigation
    
    // Segue for EventDetailSegue with details of certain event
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LovesSegue" {
            let contactShelterViewController = segue.destination as! ContactShelterViewController
//            let index = tableView.indexPathForSelectedRow!.row
//            contactShelterViewController.myLovesList = myLovesList[index]
        }
    }

}
