//
//  FavoriteMoviesModels.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import Foundation

enum FavoriteMovies{
    enum Acao {
        struct Request {
            
        }
        struct Response {
            let favoriteMovies: [MoviesModel]
        }
        struct ViewModel {
            let favoriteMovies: [MoviesModel]
        }
        struct ViewModelDetail{
            let detailMovie: MoviesModel
        }
    }
}
