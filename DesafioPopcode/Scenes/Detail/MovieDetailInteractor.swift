//
//  MovieDetailInteractor.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 24/10/21.
//

import UIKit

protocol MovieDetailBusinessLogic {
    func presentMovieDetail(request: Detail.GetMovie.Request)
}

protocol MovieDetailDataStore {
    var movie: MoviesModel? {get set}
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore{
    var movie: MoviesModel?
    var presenter: MovieDetailPresentationLogic?
    
    func presentMovieDetail(request: Detail.GetMovie.Request){
        presenter?.presentMovieDetail(movie: movie!)
    }
}
