//
//  LoveMeTableViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit

class LoveMeTableViewController: UITableViewController {
    
    let animalController = AnimalController()
    var shelterAnimals = [ShelterAnimal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        animalController.fetchAnimals { (shelterAnimals) in
            if let shelterAnimals = shelterAnimals {
                self.updateUI(with: shelterAnimals)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // Returns amount of cell rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelterAnimals.count
    }
    
    // Returns certain cell with given data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShelterAnimalCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    // Configures actual data for in the cells
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let shelterAnimal = shelterAnimals[indexPath.row]
        if shelterAnimal.animal_name != nil {
            cell.textLabel?.text = shelterAnimal.animal_name
        } else {
            cell.textLabel?.text = "nameless :("
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
