//
//  MovieDetailInteractor.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 24/10/21.
//

import UIKit

protocol MovieDetailBusinessLogic {
    func presentMovieDetail(request: Detail.GetMovie.Request)
    func getGenres(request: Detail.GetGenres.Request)
}

protocol MovieDetailDataStore {
    var movie: MoviesModel? {get set}
}

protocol GenresDataStore {
    var genres: GenreModel? {get set}
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore, GenresDataStore{
    var movie: MoviesModel?
    var genres: GenreModel?
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?
    
    func presentMovieDetail(request: Detail.GetMovie.Request){
        presenter?.presentMovieDetail(movie: movie!)
    }
    
    func getGenres(request: Detail.GetGenres.Request) {
        worker = MovieDetailWorker()
        worker?.fetchGenres(completion: { (result) in
            
            guard let resultado = result else{return}
            let response = Detail.GetGenres.Response(genres: resultado)
            
            self.presenter?.presentGenres(genres: response)
            
        })
    }
}
