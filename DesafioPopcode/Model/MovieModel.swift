//
//  MovieModel.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 14/10/21.
//

import Foundation

struct MovieModel: Decodable {
    
    var results: [MoviesModel]
    
}

struct MoviesModel: Decodable {
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var overview: String?
    var poster_path: String?
    var release_date: String?
}
