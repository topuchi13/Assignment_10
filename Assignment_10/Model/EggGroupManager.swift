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
                //print ("size of page \(String(describing: eggGroupPage.count))")
                self.fetchGroupList(eggGroupPage)
            case .failure(let error):
                print (error)
            }
        })
    }
    
    
    private func fetchGroupList(_ eggs: PKMPagedObject<PKMEggGroup>) {
        print ("Trigger fetchGroupList()")
        
        let myGroup = DispatchGroup()
        
        for i in 0 ..< eggs.count! {
            myGroup.enter()
            
            PokemonAPI().resourceService.fetch(eggs.results![i]) { result in
                switch result{
                case .success(let eggGroup):
                    //print("Fetched group name \(eggGroup.name!)")
                    self.fetchNameAndSpecies(eggGroup)
                    myGroup.leave()
                case .failure(let error):
                    print (error.localizedDescription)
                    myGroup.leave()
                }
            }
        }
        myGroup.notify(queue: .main) {
            print("Finished fetching all egg group names.")
            self.fetchFirstPokemonOfSpecie(self.species)
        }
        
    }
    
    // Get add eggGroup name and Species to respective arrays
    private func fetchNameAndSpecies(_ details: PKMEggGroup) {
        //print ("Trigger fetchNameAndSpecies()")
        self.name.append(details.name!)
        self.species.append(details.pokemonSpecies?.compactMap({$0.name}) ?? ["no specie name"])
    }
    
    
    //Fetches name of first Pokemon in each specie
    private func fetchFirstPokemonOfSpecie(_ species: [[String]]) {
        var firstPokemonNames = [String]()
        species.forEach({firstPokemonNames.append($0.first!)})
        fetchFirstSpecieImages(firstPokemonNames)
    }
    
    
    
    // Get image URL String for first pokemon in current specie
    private func fetchFirstSpecieImages(_ species: [String]) {
        print ("Trigger fetchFirstSpecieImage()")
        
        let myGroup = DispatchGroup()
        
        for i in 0 ..< species.count {
            myGroup.enter()
            
            PokemonAPI().pokemonService.fetchPokemon(species[i]) { result in
                switch result {
                case .success(let pokemon):
                    self.image.append(pokemon.sprites!.frontShiny!)
                    myGroup.leave()
                case .failure(let error):
                    print (error)
                    myGroup.leave()
                }
            }
        }
        myGroup.notify(queue: .main) {
            print("Finished fetching all first pokemon image links.")
            self.appendData()
        }
        
    }
    
    private func appendData() {
        print ("Trigger appendData()")
//        print (name.count)
//        print (image.count)
//        print(species.count)
        for i in 0..<name.count{
            self.eggGroupList.append(EggGroup(image: image[i], name: name[i], species: species[i]))
        }
    }
    
}



