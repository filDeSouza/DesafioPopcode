//
//  PopularMoviesInteractor.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

protocol PopularMoviesBusinessLogic {
    func popularMoviesRealizaRequest(pagina: Int, request: PopularMovies.Acao.Request)
    func popularSearchRequest(pagina: Int, movie: String, request: PopularMovies.Acao.Request)
    func displayMovieDetail(movie: MoviesModel)
}

protocol PopularMoviesDataStore{
    var popularMoviesModel: MovieModel?{get set}
    var movieDetailModel: MoviesModel?{get set}
}

class PopularMoviesInteractor: PopularMoviesBusinessLogic, PopularMoviesDataStore {
        
    var movieDetailModel: MoviesModel?
    var presenter: PopularMoviesPresentationLogic?
    var popularMoviesModel: MovieModel?
    var worker: PopularMoviesWorker?
    
    func popularMoviesRealizaRequest(pagina: Int, request: PopularMovies.Acao.Request) {
        worker = PopularMoviesWorker()
        worker?.fetchPopularMovies(pagina: pagina, completion: { (result) in
            
            guard let resultado = result else{return}
            let response = PopularMovies.Acao.Response(popularMovies: resultado)
            
            self.presenter?.presentPopularMovies(response: response)
            
        })
    }
    
    func popularSearchRequest(pagina: Int, movie: String, request: PopularMovies.Acao.Request){
        
        worker = PopularMoviesWorker()
        worker?.fetchSearchMovies(pagina: pagina, movie: movie, completion: { (result) in
            
            guard let resultado = result else{return}
            let response = PopularMovies.Acao.Response(popularMovies: resultado)
            
            self.presenter?.presentSearchMovies(response: response)
            
        })
        
    }
    
    func displayMovieDetail(movie: MoviesModel) {
        presenter?.presentMovieDetail(movie: movie)
    }
    
}
