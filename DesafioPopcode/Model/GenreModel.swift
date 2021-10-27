//
//  GenreModel.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 26/10/21.
//

import Foundation

struct GenreModel: Decodable{
    
    var genres: [Genre]
    
}

struct Genre: Decodable{
    
    var id: Int
    var name: String
    
}
