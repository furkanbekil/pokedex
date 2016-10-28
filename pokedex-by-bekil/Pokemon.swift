//
//  Pokemon.swift
//  pokedex-by-bekil
//
//  Created by furkan bekil on 14.10.2016.
//  Copyright © 2016 furkan bekil. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var attack: String {
        if _type == nil {
            _type = ""
        }
        return _attack
    }
    
    var defense: String {
        if _type == nil {
            _type = ""
        }
        return _defense
    }
    
    var height: String {
        if _type == nil {
            _type = ""
        }
        return _height
    }
    
    var weight: String {
        if _type == nil {
            _type = ""
        }
        return _weight
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonUrl).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? Int {
                    self._weight = "\(weight)"
                }
                
                if let height = dict["height"] as? Int {
                    self._height = "\(height)"
                }
                
                
                print(self._weight)
                print(self._height)
                
                if let types = dict["types"] as? [Dictionary<String, AnyObject>] , types.count > 0 {
                    
                    if let type = types[0]["type"] {
                        if let name = type["name"] as? String {
                            self._type = "\(name)"
                        }
                        
                    }
                    
                    if types.count > 1 {
                        for _ in 1 ..< types.count {
                            if let type = types[1]["type"] {
                                if let name = type["name"] as? String {
                                    self._type! += "/\(name)"
                                }
                            }
                        }
                    }
                    
                } else {
                    self._type = "merhaba"
                }
                print(self._type)
                
                if let stats = dict["stats"] as? [Dictionary<String, AnyObject>], stats.count > 0 {
                    if let stat = stats[2]["base_stat"] as? Int {
                        self._attack = "\(stat)"
                    } else {
                        self._attack = "there is no attack"
                    }
                    
                    if let stat = stats[1]["base_stat"] as? Int {
                        self._defense = "\(stat)"
                    } else {
                        self._defense = "there is no defense"
                    }
                }
                
                print(self._attack)
                print(self._defense)
                
                
            }; completed()
            
            
            
        }
        
        
    
    
    }
    
}
