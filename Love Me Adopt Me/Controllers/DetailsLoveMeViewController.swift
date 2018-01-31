//
//  DetailsLoveMeViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DetailsLoveMeViewController: UIViewController {

    var shelterAnimal: ShelterAnimal!
    var delegate: AddToMyLovesDelegate?
    var user: User!
    var refMyLoves: DatabaseReference!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var addToLovesButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        activityIndicator.startAnimating()
        if shelterAnimal.animal_name != nil {
            nameLabel.text = shelterAnimal.animal_name
        } else {
            nameLabel.text = "nameless :("
        }
        
        if shelterAnimal.animal_type != nil {
            typeLabel.text = shelterAnimal.animal_type
        } else {
            typeLabel.text = "no defined type :("
        }
        
        if shelterAnimal.animal_breed != nil {
            breedLabel.text = shelterAnimal.animal_breed
        } else {
            breedLabel.text = "no defined breed :("
        }
        
        ageLabel.text = shelterAnimal.age
        genderLabel.text = shelterAnimal.animal_gender
        memoLabel.text = shelterAnimal.memo
        addToLovesButton.layer.cornerRadius = 25.0
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupDelegate() {
        if let navController = tabBarController?.viewControllers?.first as? UINavigationController,
            let myLovesListTableViewController = navController.viewControllers.last as? MyLovesListTableViewController {
            delegate = myLovesListTableViewController
        }
    }

    @IBAction func loveMeButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.addToLovesButton.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.addToLovesButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(shelterAnimal: shelterAnimal)
        addLove()
    }
    
    // Adds event as child of 'user' to Firebase with properties 'id' and 'eventName'
    func addLove() {
        let userID = (Auth.auth().currentUser?.uid)!
//        let userEmailFirebase = userEmail.makeFirebaseString()

        refMyLoves = Database.database().reference()
        let key = refMyLoves?.childByAutoId().key
        let image = String(describing: shelterAnimal.image!)
        let link = String(describing: shelterAnimal.link!)
        let animal_id = shelterAnimal.animal_id as String?
        
        let events = ["id": key!,
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
                      "memo": shelterAnimal.memo as String?
            ]
        
        refMyLoves.child("lists-of-users").child(userID).child(animal_id!).setValue(events)
    }
    
}

//extension String {
//    func makeFirebaseString() -> String {
//        let characterToReplace = [".","#","$","[","]"]
//        var finalString = self
//
//        for character in characterToReplace{
//            finalString = finalString.replacingOccurrences(of: character, with: "")
//        }
//
//        return finalString
//    }
//}

