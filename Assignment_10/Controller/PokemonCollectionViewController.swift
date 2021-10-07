//
//  PokemonCollectionViewController.swift
//  PokemonCollectionViewController
//
//  Created by Nika Topuria on 06.10.21.
//

import UIKit
import PokemonAPI
import Kingfisher

private let reuseIdentifier = "Cell"

class PokemonCollectionViewController: UICollectionViewController{
    
    let eggGroupManager = EggGroupManager()
    
    private let reusableCell = "PokeSection"
    
    private let sectionInsets = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        
        //Fetch egg group list
        eggGroupManager.fetchEggGroupDetails()
    }

    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let count = eggGroupManager.eggGroupList.count
        print ("Collection View triggered count: \(count)")
        return count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCell, for: indexPath) as! PokeSection
        // Configure the cell
        
        let currentGroup = eggGroupManager.eggGroupList[indexPath.row]
        let name = currentGroup.name
        let imageURL = URL(string: currentGroup.image)
        
        print ("Collection View triggered name: \(name)")
        print ("Collection View triggered image: \(currentGroup.image)")

        cell.eggGroupImage.kf.setImage(with: imageURL)
        cell.eggGroupLabel.text = name
        return cell
        
    }


  
}
