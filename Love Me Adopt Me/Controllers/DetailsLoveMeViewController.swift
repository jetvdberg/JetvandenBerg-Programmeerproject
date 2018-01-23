//
//  DetailsLoveMeViewController.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 11-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit

class DetailsLoveMeViewController: UIViewController {

    var shelterAnimal: ShelterAnimal!
    var delegate: AddToMyLovesDelegate?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var addToLovesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupDelegate()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        nameLabel?.text = shelterAnimal.animal_name
        typeLabel.text = shelterAnimal.animal_type
        breedLabel.text = shelterAnimal.animal_breed
        ageLabel.text = shelterAnimal.age
        genderLabel.text = shelterAnimal.animal_gender
        memoLabel.text = shelterAnimal.memo
        addToLovesButton.layer.cornerRadius = 5.0
        
        AnimalController.shared.fetchImage(url: shelterAnimal.image!)
        { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
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
    }
}
