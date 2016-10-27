//
//  pokemonDetailVC.swift
//  pokedex-by-bekil
//
//  Created by furkan bekil on 18.10.2016.
//  Copyright © 2016 furkan bekil. All rights reserved.
//

import UIKit

class pokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var nextEvoLbl: UILabel!
    @IBOutlet weak var evoImg1: UIImageView!
    @IBOutlet weak var evoImg2: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()


        nameLbl.text = pokemon.name
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        pokemon.downloadPokemonDetails { 
            
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }


}
