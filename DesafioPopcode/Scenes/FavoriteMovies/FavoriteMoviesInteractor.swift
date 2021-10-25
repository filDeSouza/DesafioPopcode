//
//  FavoriteMoviesInteractor.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import UIKit

protocol FavoriteMoviesBusinessLogic {
    func favoriteMoviesRealizaRequest(request: FavoriteMovies.Acao.Request)
    func displayMovieDetail(movie: MoviesModel)
}

protocol FavoriteMoviesDataStore {
    var favoriteMoviesModel: [MoviesModel]?{get set}
    var movieDetailModel: MoviesModel?{get set}
}

class FavoriteMoviesInteractor: FavoriteMoviesBusinessLogic, FavoriteMoviesDataStore{
    var movieDetailModel: MoviesModel?
    var presenter: FavoriteMoviesPresentationLogic?
    var favoriteMoviesModel: [MoviesModel]?
    var worker: FavoriteMoviesWorker?
    
    func favoriteMoviesRealizaRequest(request: FavoriteMovies.Acao.Request) {
        worker = FavoriteMoviesWorker()
        worker?.fetchFavoriteMovies(completion: { (result) in
            
            guard let resultado = result else{return}
            let response = FavoriteMovies.Acao.Response(favoriteMovies: resultado)
            
            self.presenter?.presentFavoriteMovies(response: response)
            
        })
    }
    
    func displayMovieDetail(movie: MoviesModel) {
        presenter?.presentMovieDetail(movie: movie)
    }
    
}
