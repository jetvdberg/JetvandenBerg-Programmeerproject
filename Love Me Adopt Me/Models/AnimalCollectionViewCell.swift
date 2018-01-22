//
//  AnimalCollectionViewCell.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit

class AnimalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalTypeLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!

    let animalController = AnimalController()
    var shelterAnimals = [ShelterAnimal]()
    

    
    
//    // Returns amount of cell rows
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return shelterAnimals.count
//    }
    
    // Returns certain cell with given data

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: AnimalCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "animalCell", for: indexPath) as! AnimalCollectionViewCell
//        configure(cell: cell, forItemAt: indexPath)
//        return cell
//    }
//
//    // Configures actual data for in the cells
//    func configure(cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let shelterAnimal = shelterAnimals[indexPath.row]
//        if shelterAnimal.animal_name != nil {
//            animalTypeLabel.text = shelterAnimal.animal_name
//        } else {
//            animalTypeLabel?.text = "nameless :("
//        }
//    }
    
    
    
    
    
    
//    var shelterAnimal: ShelterAnimal! {
//
//        didSet {
//            updateData()
//        }
//    }
//
//    func updateData() {
//        animalTypeLabel.text = shelterAnimal.animal_breed
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
