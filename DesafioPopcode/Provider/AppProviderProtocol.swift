//
//  AppProviderProtocol.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

protocol PopularMoviesProviderProtocol {
    func obterPopularMovies(pagina: Int, completion: @escaping([MoviesModel]?) -> Void)
    func getSearchMovies(pagina: Int, movie: String, completion: @escaping([MoviesModel]?) -> Void)
    func getFavoriteMovies(completion: @escaping([MoviesModel]?) -> Void)
}
