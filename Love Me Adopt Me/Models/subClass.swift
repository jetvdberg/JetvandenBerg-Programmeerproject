//
//  subClass.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//
//  This class creates the CollectionView, with the CollectionViewCells inside of it. This CollectionView holds the data for all the shelter animals.
//

import UIKit

class subClass : UITableViewCell {
    
    // Properties
    var shelterAnimals = [ShelterAnimal]()
    let animalController = AnimalController()
    
    // Outlet
    @IBOutlet weak var collectionView: UICollectionView!
}

// Extension of subClass: manages the CollectionView settings and data
extension subClass : UICollectionViewDataSource, UICollectionViewDelegate {
    
    // Returns number of cells in CollectionViewRow
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shelterAnimals.count
    }
    
    // Configures each cell in CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shelterAnimal = shelterAnimals[indexPath.row]
        
        // Defines cell and fills up each cell and label with corresponding data
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalCell", for: indexPath) as! AnimalCollectionViewCell
        cell.animalActivityIndicator.startAnimating()
        cell.animalImageView?.image = #imageLiteral(resourceName: "dogcatGrijs")
        cell.shelterAnimal = shelterAnimal
        cell.animalNameLabel.text = (shelterAnimal.animal_name != nil) ? shelterAnimal.animal_name : "nameless :("
        cell.animalAgeLabel.text = (shelterAnimal.age != nil) ? shelterAnimal.age : "Unknown"
        
        // Checks for existing image and fills imageView with image
        let animalImage: URL? = shelterAnimal.image
        if let animalIMG = animalImage {
            AnimalController.shared.fetchImage(url: animalIMG) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    if let currentIndexPath = self.collectionView.indexPath(for: cell),
                        currentIndexPath != indexPath {
                        return
                    }
                    cell.animalImageView?.image = (shelterAnimal.image != nil) ? image : #imageLiteral(resourceName: "dogcatGrijs")
                    cell.animalActivityIndicator.stopAnimating()
                }
            }
        }
        return cell
    }
    
}

// Extension of subClass: manages the CollectionView layout
extension subClass : UICollectionViewDelegateFlowLayout {
    
    // Creates layout for each CollectionViewRow and its items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.5
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
