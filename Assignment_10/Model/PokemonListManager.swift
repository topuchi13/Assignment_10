//
//  PokemonListManager.swift
//  PokemonListManager
//
//  Created by Nika Topuria on 08.10.21.
//

import UIKit
import PokemonAPI


class PokemonListManager {
    
    var pokemonList: [PKMPokemon] = []
    
    var tempEggGroupName: String = ""
    
    func fetchAllSpecies(_ groupNames: [String], _ eggGroup: [[String]]){
        //print ("Trigger fetchAllSpecies()")
        for i in 0..<eggGroup.count {
            tempEggGroupName = groupNames[i]
            fetchPokemonData(eggGroup[i])
        }
    }
    

    
    func fetchPokemonData(_ species: [String]) {
        //print ("Trigger fetchPokemonNames()")
        
        let myGroup = DispatchGroup()
        
        for i in 0..<species.count {
            myGroup.enter()
            
            PokemonAPI().pokemonService.fetchPokemon(species[i]) { result in
                switch result {
                case .success(let pokemon):
                    self.pokemonList.append(pokemon)
                    myGroup.leave()
                case .failure(let error):
                    print (error)
                    myGroup.leave()
                }
            }
            
        }
        myGroup.notify(queue: .main) {
            PokemonSource[self.tempEggGroupName] = self.pokemonList
            self.pokemonList = []
            self.tempEggGroupName = ""
        }
        
    }
    
    
}
