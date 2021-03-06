//
//  TableViewCell.swift
//  TableViewCell
//
//  Created by Nika Topuria on 05.10.21.
//

import UIKit
import Kingfisher
import PokemonAPI

class BasicCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBOutlet var pokeImage: UIImageView!
    @IBOutlet var pokeLabel: UILabel!
    
    
    // Defines function to make new Pokemon entries
    
    func makeNewPokemon (myPokemon: PKMPokemon) {
        pokeImage.kf.setImage(with: URL(string: myPokemon.sprites!.frontDefault!))
        pokeLabel.text = myPokemon.name
    }
    
    
}
