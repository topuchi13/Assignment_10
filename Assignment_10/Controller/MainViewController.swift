//
//  ViewController.swift
//  Assignment_10
//
//  Created by Nika Topuria on 04.10.21.
//

//შექმენით TableView 10 Cell-ით
//თითოეულ სელში იყოს 1 რაიმე სურათი და მოკლე ტექსტი
//სელზე დაჭერისას გადავიდეს ახალ გვერდზე, სადაც იქნება ის ფოტო რომელ სელსაც დააჭირა.
//Extra 20 points - გამოიყენეთ MVC არქიტექტურა.


import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var delegate: pokeLargeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! pokeLargeView
        self.delegate = vc
    }
}


//MARK: - UITableViewDataSource extension

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PokemonSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as! BasicCell
        
        cell.makeNew(myPokemon: PokemonSource[indexPath.row])
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate extension

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pokeShow(PokemonSource[indexPath.row])
    }
}


//MARK: - pokeLargeView protocol implementation for delegate pattern

protocol pokeLargeView {
    func pokeShow(_ poke: Pokemon)
}
