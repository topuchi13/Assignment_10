//
//  ViewController.swift
//  ViewController
//
//  Created by Nika Topuria on 05.10.21.
//

import UIKit

class EnlargedViewController: UIViewController {

    
    @IBOutlet var pokeName: UILabel!
    @IBOutlet var pokeImage: UIImageView!
    @IBOutlet var pokeDescription: UILabel!
    
}

//MARK: - Extends class to conform with pokeLargeView protocol

extension EnlargedViewController: pokeLargeView{
    func pokeShow(_ poke: Pokemon) {
        pokeName.text = poke.name
        pokeImage.image = UIImage.init(imageLiteralResourceName: poke.image)
        pokeDescription.text = poke.text
    }
    
    
}
