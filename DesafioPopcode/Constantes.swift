//
//  Constantes.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 14/10/21.
//

import Foundation

class Constants{
    
    static let base_url = "https://api.themoviedb.org/3/"
    static let url_images = "https://image.tmdb.org/t/p/w500"
    static let api_key = "953ef942a613bbf91df9afd93f627ce4"
    static let endpoint_popular_movie = "movie/popular?api_key="
    static let endpoint_search = "search/movie?api_key="
    static let endpoint_genres = "genre/movie/list?api_key="
    static let endpoint_language = "&language="
    static let language = "pt-BR"
    static let page = "&page="
    static let query = "&query="
    static let cellIdentifier = "reusableCell"
    static let cellNibName = "MoviesCollectionViewCell"
    
    static let cellFavoriteMoviesIdentifier = "reusableCellFavorite"
    static let cellFavoriteMoviesNibName = "MoviesTableViewCell"
    
    struct FStore{
        static let collectionName = "movies"
        static let movieID = "id"
        static let original_title = "original_title"
        static let genre_ids = "genre_ids"
        static let overview = "overview"
        static let poster_path = "poster_path"
        static let release_date = "release_date"
    }
    
}
