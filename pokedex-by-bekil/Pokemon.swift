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
    private var _evolutionUrl: String!
    private var _evolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    
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
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var evolutionName: String {
        if _evolutionName == nil {
            _evolutionName = ""
        }
        return _evolutionName
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        _evolutionUrl = "\(URL_BASE_EVOLUTİON)\(URL_POKEMON)\(self.pokedexId)"
        
        
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
                
                Alamofire.request(self._evolutionUrl).responseJSON { response in
                    print(response.request)  // original URL request
                    print(response.response) // HTTP URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                    
                    if let dictEvo = response.result.value as? Dictionary<String, AnyObject> {
                        if let evolutions = dictEvo["evolutions"] as? [Dictionary<String, AnyObject>] {
                            if let evoName = evolutions[0]["to"] as? String {
                                
                               
                                    
                                    if let uri = evolutions[0]["resource_uri"] as? String {
                                        
                                        let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                        
                                        let num = newStr.replacingOccurrences(of: "/", with: "")
                                        
                                        self._nextEvolutionId = num
                                        self._evolutionName = evoName
                                        
                                        if let lvl = evolutions[0]["level"] as? Int {
                                            self._nextEvolutionLvl = "\(lvl)"
                                        }
                                        
                                        print(self._nextEvolutionId)
                                        print(self._evolutionName)
                                        
                                        
                                    }
                            } else {
                                self._nextEvolutionId = ""
                                self._evolutionName = ""
                                self._nextEvolutionLvl = ""
                            }
                            
                                
                            
                        }
                        
                        if let descriptions = dictEvo["descriptions"] as? [Dictionary<String, AnyObject>] , descriptions.count > 0{
                            if let descUri = descriptions[0]["resource_uri"] {
                                let urlForDesc = "\(URL_BASE_FOR_DESC)\(descUri)"
                                
                                Alamofire.request(urlForDesc).responseJSON { response in
                                    print(response.request)  // original URL request
                                    print(response.response) // HTTP URL response
                                    print(response.data)     // server data
                                    print(response.result)   // result of response serialization
                                    
                                    if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                        if let descs = descDict["description"] as? String {
                                            self._description = "\(descs)"
                                            print(self._description)
                                            ; completed()
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    
                    
                }
                
                
            }
            
        }
        
        
    }
    
}
