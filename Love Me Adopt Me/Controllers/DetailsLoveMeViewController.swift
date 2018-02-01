//
//  DetailsLoveMeViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class displays all the details of a certain animal (which was selected by the user in LoveMeViewController). The user can 'like' this animal by tapping the 'Love Me' button. This will add the animal to an array via a delegate, in the MyLovesViewController.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DetailsLoveMeViewController: UIViewController {

    // Properties
    var shelterAnimal: ShelterAnimal!
    var delegate: AddToMyLovesDelegate?
    var user: User!
    var refMyLoves = Database.database().reference()
    
    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addToLovesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Loads view, performs functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()
    }
    
    // Checks for each label/imageView if data exists, fills in labels/imageView
    func updateUI() {
        activityIndicator.startAnimating()
        nameLabel.text = (shelterAnimal.animal_name != nil) ? shelterAnimal.animal_name : "nameless :("
        typeLabel.text = (shelterAnimal.animal_type != nil) ? shelterAnimal.animal_type : "Unknown"
        breedLabel.text = (shelterAnimal.animal_breed != nil) ? shelterAnimal.animal_breed : "Unknown"
        ageLabel.text = (shelterAnimal.age != nil) ? shelterAnimal.age : "Unknown"
        genderLabel.text = (shelterAnimal.animal_gender != nil) ? shelterAnimal.animal_gender : "Unknown"
        colorLabel.text = (shelterAnimal.animal_color != nil) ? shelterAnimal.animal_color : "Unknown"
        cityLabel.text = (shelterAnimal.city != nil) ? shelterAnimal.city : "Unknown"
        addToLovesButton.layer.cornerRadius = 25.0
        
        // Checks for image, fetches image
        let animalImage = shelterAnimal.image
        if let animalIMG = animalImage {
            AnimalController.shared.fetchImage(url: animalIMG)
            { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
            imageView.layer.cornerRadius = 25.0
        }
    }
    
    // Sets up delegate to send data to MyLovesListTableViewController (first in tabBarController)
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?.first as? UINavigationController,
            let myLovesListTableViewController = navController.viewControllers.last as? MyLovesListTableViewController {
            delegate = myLovesListTableViewController
        }
    }

    // Button for adding 'Love' to list
    @IBAction func loveMeButtonTapped(_ sender: UIButton) {
        
        // Animates when button is tapped
        UIView.animate(withDuration: 0.2) {
            self.addToLovesButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToLovesButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        // Sends added shelterAnimal data via delegate to MyLovesListTableViewController
        delegate?.added(shelterAnimal: shelterAnimal)
        addLove()
    }
    
    // Adds 'Love' to list of user in Firebase
    func addLove() {
        
        // Defines needed properties
        let userID = (Auth.auth().currentUser?.uid)!
        let key = refMyLoves.childByAutoId().key
        let image = String(describing: shelterAnimal.image!)
        let link = String(describing: shelterAnimal.link!)
        let animal_id = shelterAnimal.animal_id as String?
        
        // Sets values for keys used in Firebase
        let animals = ["id": key,
                      "animal_age": shelterAnimal.age as String?,
                      "animal_breed": shelterAnimal.animal_breed as String?,
                      "animal_color": shelterAnimal.animal_color as String?,
                      "animal_gender": shelterAnimal.animal_gender as String?,
                      "animal_id": shelterAnimal.animal_id as String?,
                      "animal_name": shelterAnimal.animal_name as String?,
                      "animal_type": shelterAnimal.animal_type as String?,
                      "city": shelterAnimal.city as String?,
                      "current_location": shelterAnimal.current_location as String?,
                      "image": image,
                      "link": link,
                      "memo": shelterAnimal.memo as String?]
        
        // Creates new path in Firebase, creating list for every user
        refMyLoves.child("lists-of-users").child(userID).child(animal_id!).setValue(animals)
    }
    
}
