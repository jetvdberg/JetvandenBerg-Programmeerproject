//
//  AnimalTypeRow.swift
//  Love Me Adopt Me
//
//  Created by Jet van den Berg on 18-01-18.
//  Copyright © 2018 Jet van den Berg. All rights reserved.
//

import UIKit

class subClass : UITableViewCell {
    
    var shelterAnimals = [ShelterAnimal]()
    let animalController = AnimalController()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
}

extension subClass : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shelterAnimals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shelterAnimal = shelterAnimals[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalCell", for: indexPath) as! AnimalCollectionViewCell
        
        cell.animalActivityIndicator.startAnimating()
        
        if shelterAnimal.animal_name != nil {
            cell.animalTypeLabel.text = shelterAnimal.animal_name
        } else {
            cell.animalTypeLabel?.text = "nameless :("
        }
//        cell.animalImageView?.image = #imageLiteral(resourceName: "LoveMeLogo")
        
        cell.shelterAnimal = shelterAnimal
        
        let animalImage: URL? = shelterAnimal.image
        if let animalIMG = animalImage {
            
            AnimalController.shared.fetchImage(url: animalIMG) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    if let currentIndexPath = self.collectionView.indexPath(for: cell),
                        currentIndexPath != indexPath {
                        return
                    }
                    
                    if shelterAnimal.image != nil {
                        cell.animalImageView?.image = image
                        cell.animalActivityIndicator.stopAnimating()
                    } else {
                        cell.animalImageView?.image = #imageLiteral(resourceName: "LoveMeLogo")
                    }
                }
            }
        }
        return cell
    }
    
}

extension subClass : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.7
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
