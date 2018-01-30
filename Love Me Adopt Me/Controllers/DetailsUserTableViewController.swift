//
//  DetailsUserTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DetailsUsersTableViewController: UITableViewController {
    
    var shelterAnimals = [ShelterAnimal]()
    var myLovesList = [LovesModel]()
    var user: User!
    
    var dataRef = Database.database().reference()
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Checks for existing data in Firebase
        dataRef.child("lists-of-users").child(user.uid).observeSingleEvent(of: .value, with: { snapshot in
            
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
        })
    }
    
    func updateUI() {
        userEmailLabel.text = user.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLovesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
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

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
