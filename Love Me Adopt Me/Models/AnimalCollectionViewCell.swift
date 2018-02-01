//
//  AnimalCollectionViewCell.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class creates a cell for the CollectionView, holds its outlets and updates the layout. The shelter animals will be displayed in these cells.
//

import UIKit

class AnimalCollectionViewCell: UICollectionViewCell {
    
    // Properties
    let animalController = AnimalController()
    var shelterAnimal : ShelterAnimal?
    
    // Outlets
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalNameLabel: UILabel!
    @IBOutlet weak var animalAgeLabel: UILabel!
    @IBOutlet weak var animalActivityIndicator: UIActivityIndicatorView!
    
    // Creates layout for each CollectionViewCell
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
