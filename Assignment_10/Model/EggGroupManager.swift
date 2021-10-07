//
//  EggGroupController.swift
//  EggGroupController
//
//  Created by Nika Topuria on 07.10.21.
//

import UIKit
import PokemonAPI
import Kingfisher

class EggGroupManager {
    
    var eggGroupList: [EggGroup] = []
    
    var image = [String]()
    var name = [String]()
    var species = [[String]]()
    
    func fetchEggGroupDetails() {
        print ("Trigger fetchEggGroupDetails()")
        // Get list of Pokemon Egg Groups
        
        PokemonAPI().pokemonService.fetchEggGroupList(completion: { result in
            switch result {
            case .success(let eggGroupPage):
                print ("size of page \(self.eggGroupList.count)")
                self.fetchGroupList(eggGroupPage)
            case .failure(let error):
                print (error)
            }
        })
        
    }
    
    private func fetchGroupList(_ eggs: PKMPagedObject<PKMEggGroup>) {
        print ("Trigger fetchGroupList()")
        var details: [PKMEggGroup] = []
        eggs.results!.forEach({PokemonAPI().resourceService.fetch($0) { result in
            switch result{
            case .success(let eggGroup):
                details.append(eggGroup)
            case .failure(let error):
                print (error.localizedDescription)
            }
        }})

        print ("FetchGroupList details Count \(details.count)")
        fetchNameAndSpecies(details)
    }
    
    
    private func fetchNameAndSpecies(_ details: [PKMEggGroup]) {
        print ("Trigger fetchNameAndSpecies()")
        details.forEach { eggGroup in
            self.name.append(eggGroup.name!)
            self.species.append(eggGroup.pokemonSpecies?.compactMap({$0.name}) ?? ["no specie name"])
        }
        fetchFirstPokemonOfSpecie(species)
    }
    
    
    private func fetchFirstPokemonOfSpecie(_ species: [[String]]) {
        var firstPokemonNames = [String]()
        species.forEach({firstPokemonNames.append($0.first!)})
        fetchFirstSpecieImages(firstPokemonNames)
    }
    
    
    
    
    // Get image URL String for first pokemon in current specie
    private func fetchFirstSpecieImages(_ species: [String]) {
        print ("Trigger fetchFirstSpecieImage()")
        
        species.forEach({PokemonAPI().pokemonService.fetchPokemon($0) { result in
            switch result {
            case .success(let pokemon):
                self.image.append(pokemon.sprites!.frontShiny!)
            case .failure(let error):
                print (error)
            }
        }})
        self.appendData()
    }
    
    private func appendData() {
        print ("Trigger appendData()")
        print (name.count)
        print (image.count)
        print(species.count)
        //self.eggGroupList.append(EggGroup(image: image, name: name, species: species))
    }
    
    
}



