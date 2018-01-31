//
//  AnimalCollectionViewCell.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit

class AnimalCollectionViewCell: UICollectionViewCell {
    
    let animalController = AnimalController()
    var shelterAnimal : ShelterAnimal?

    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var animalActivityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
