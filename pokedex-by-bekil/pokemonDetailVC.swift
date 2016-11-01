//
//  pokemonDetailVC.swift
//  pokedex-by-bekil
//
//  Created by furkan bekil on 18.10.2016.
//  Copyright © 2016 furkan bekil. All rights reserved.
//

import UIKit
import SwiftSpinner
import GoogleMobileAds



class pokemonDetailVC: UIViewController, GADInterstitialDelegate {
    
    var interstitialAd: GADInterstitial?
    
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
        
        interstitialAd = createAndLoadInterstitial()
        
        SwiftSpinner.show("")
        pokemon.downloadPokemonDetails { () -> () in
            
            self.updateUI()
            SwiftSpinner.hide()
            
            
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showAdButton()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let request = GADRequest()
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(request)
        return interstitial
    }
    
    func showAdButton() {
        if interstitialAd != nil {
            if interstitialAd!.isReady {
                interstitialAd?.present(fromRootViewController: self)
                
            }
        }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial!) {
        interstitialAd = createAndLoadInterstitial()
    }
    
    
    
    
    func updateUI() {
        typeLbl.text = "\(pokemon.type)"
        baseAttackLbl.text = "\(pokemon.attack)"
        defenseLbl.text = "\(pokemon.defense)"
        heightLbl.text = "\(pokemon.height)"
        weightLbl.text = "\(pokemon.weight)"
        descriptionLbl.text = "\(pokemon.description)"
        nameLbl.text = pokemon.name
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        evoImg1.image = img
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvolutionId == "" {
            nextEvoLbl.text = "No Evolutions"
            evoImg2.isHidden = true
        } else {
            evoImg2.isHidden = false
            evoImg2.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.evolutionName)"
            
            if pokemon.nextEvolutionLvl != "" {
                str += " - LVL \(pokemon.nextEvolutionLvl)"
            }
            
            nextEvoLbl.text = str
        }
        
        
    }
    
    
    
    @IBAction func backBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    


}
