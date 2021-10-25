//
//  PopularMoviesModels.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import Foundation

enum PopularMovies{
    enum Acao {
        struct Request {
            
        }
        struct Response{
            let popularMovies: [MoviesModel]
        }
        struct ViewModel{
            let popularMovies: [MoviesModel]
        }
        struct ViewModelDetail{
            let detailMovie: MoviesModel
        }
    }
}
