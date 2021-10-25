//
//  MovieDetailPresenter.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 24/10/21.
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentMovieDetail(movie: MoviesModel)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    
    var viewController: MovieDetailDisplayLogic?
    
    func presentMovieDetail(movie: MoviesModel) {
        viewController?.displayMovieDetail(movie: Detail.GetMovie.ViewModel(movie: movie))
    }
}
