//
//  TableViewCell.swift
//  TableViewCell
//
//  Created by Nika Topuria on 05.10.21.
//

import UIKit

class BasicCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet var pokeImage: UIImageView!
    @IBOutlet var pokeLabel: UILabel!
    
    
    // Defines function to make new Pokemon entries
    
    func makeNewPokemon (myPokemon: Pokemon) {
        pokeImage.image = UIImage.init(imageLiteralResourceName: myPokemon.image)
        pokeLabel.text = myPokemon.text
    }
    
    
}
