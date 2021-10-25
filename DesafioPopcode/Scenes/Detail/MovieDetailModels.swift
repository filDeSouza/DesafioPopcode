//
//  MovieDetailModels.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 24/10/21.
//

import Foundation

enum Detail{
    enum GetMovie {
        struct Request {
            
        }
        struct Response {
            var movie: MoviesModel
        }
        struct ViewModel {
            var movie: MoviesModel
        }
    }
}
