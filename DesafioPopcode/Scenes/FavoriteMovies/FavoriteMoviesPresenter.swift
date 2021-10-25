//
//  FavoriteMoviesPresenter.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import UIKit

protocol FavoriteMoviesPresentationLogic {
    func presentFavoriteMovies(response: FavoriteMovies.Acao.Response)
    func presentMovieDetail(movie: MoviesModel)
}

class FavoriteMoviesPresenter: FavoriteMoviesPresentationLogic {
    
    var viewController: FavoriteMoviesDisplayLogic?
    
    func presentFavoriteMovies(response: FavoriteMovies.Acao.Response) {
        
        let viewModel = FavoriteMovies.Acao.ViewModel(favoriteMovies: response.favoriteMovies)
        
        viewController?.displayFavoriteMovies(viewModel: viewModel)
        
    }
    
    func presentMovieDetail(movie: MoviesModel) {
        let viewModel = FavoriteMovies.Acao.ViewModelDetail(detailMovie: movie)
        
        viewController?.displayMovieDetail(viewModel: viewModel)
    }
}
