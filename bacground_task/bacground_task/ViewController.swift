//
//  ViewController.swift
//  bacground_task
//
//  Created by Константин Ирошников on 15.06.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon(id: 1)
    }

    func fetchPokemon(id: Int) {
        PokeManager.pokemon(id: id) { (pokemon) in
          self.name.text = pokemon.species.name
          PokeManager.downloadImage(url: pokemon.sprites.backDefault!) { (image) in
            self.image.image = image
          }
        }
    }

}

