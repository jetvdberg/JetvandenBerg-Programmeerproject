//
//  MyLovesListTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol AddToMyLovesDelegate {
    func added(shelterAnimal: ShelterAnimal)
}

class MyLovesListTableViewController: UITableViewController, AddToMyLovesDelegate {
    
    var shelterAnimals = [ShelterAnimal]()
    
//    let listToUsers = "ListToUsers"
//    var myLovesList = [LovesModel]()
//    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
//        Auth.auth().addStateDidChangeListener { auth, user in
//            guard let user = user else { return }
//            self.user = User(authData: user)
//        }
//
    }

    // MARK: - Table view data source

    // Reloads view
//    override func viewDidAppear(_ animated: Bool) {
//        viewDidLoad()
//    }
    // MARK: - Table view data source
    
    // Returns number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("_______shelterAnimals.count")
        print(shelterAnimals.count)
        return shelterAnimals.count
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
//            dataRef.child(eventsList[indexPath.row].id!).removeValue()
            shelterAnimals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            viewDidLoad()
            updateBadgeNumber()
        }
    }
    
    // Configures cells with animal details
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let shelterAnimal = shelterAnimals[indexPath.row]
        if shelterAnimal.animal_name != nil {
            cell.textLabel?.text = shelterAnimal.animal_name
            cell.detailTextLabel?.text = shelterAnimal.animal_breed
        } else {
            cell.textLabel?.text = "nameless :("
            cell.detailTextLabel?.text = shelterAnimal.animal_breed
        }
    }
    
    // Counts number of favorites in list
    func added(shelterAnimal: ShelterAnimal) {
        shelterAnimals.append(shelterAnimal)
        let count = shelterAnimals.count
        print("_____count")
        print(count)
        let indexPath = IndexPath(row: count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
//        viewDidLoad()
        updateBadgeNumber()
    }
    
    // Updates number representing favorites in list
    func updateBadgeNumber() {
        let badgeValue = shelterAnimals.count > 0 ? "\(shelterAnimals.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
        print("_____badgeValue")
        print(badgeValue)
    }

}
