//
//  EntryViewController.swift
//  EntryViewController
//
//  Created by Nika Topuria on 07.10.21.
//

import UIKit

class EntryViewController: UIViewController {

    let eggGroupManager = EggGroupManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eggGroupManager.fetchEggGroupDetails()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PokemonCollectionViewController

        vc.eggGroup = eggGroupManager.eggGroupList
        vc.pokemonListManager.fetchAllSpecies(eggGroupManager.name, eggGroupManager.species)
    }
    

}
