//
//  LoveMeViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//


import UIKit

class LoveMeViewController: UIViewController {
    var animalTypes = ["Dogs", "Cats", "Birds", "Pigs"]
    
    let animalController = AnimalController()
    var shelterAnimals = [ShelterAnimal]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimalController.shared.fetchAnimals { (shelterAnimals) in
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
        cell.shelterAnimals = self.shelterAnimals
        cell.collectionView.reloadData()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178.0
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
