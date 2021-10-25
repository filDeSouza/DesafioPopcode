//
//  PopularMoviesPresenter.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

protocol PopularMoviesPresentationLogic {
    func presentPopularMovies(response: PopularMovies.Acao.Response)
    func presentSearchMovies(response: PopularMovies.Acao.Response)
    func presentMovieDetail(movie: MoviesModel)
}

class PopularMoviesPresenter: PopularMoviesPresentationLogic {

    var viewController: PopularMoviesDisplayLogic?
    
    func presentPopularMovies(response: PopularMovies.Acao.Response) {
        
        let viewModel = PopularMovies.Acao.ViewModel(popularMovies: response.popularMovies)
        
        viewController?.displayPopularMovies(viewModel: viewModel)
        
    }
    
    func presentSearchMovies(response: PopularMovies.Acao.Response) {
        
        let viewModel = PopularMovies.Acao.ViewModel(popularMovies: response.popularMovies)
        
        viewController?.displaySearchMovies(viewModel: viewModel)
        
    }
    
    func presentMovieDetail(movie: MoviesModel) {
        let viewModel = PopularMovies.Acao.ViewModelDetail(detailMovie: movie)
        
        viewController?.displayMovieDetail(viewModel: viewModel)
    }
    
}
