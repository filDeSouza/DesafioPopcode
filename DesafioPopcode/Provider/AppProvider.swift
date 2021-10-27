//
//  AppProvider.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

class AppProvider: PopularMoviesProviderProtocol {

    let apiService = APIService()
    let firebaseService = FirebaseService()
    
    func obterPopularMovies(pagina: Int, completion: @escaping ([MoviesModel]?) -> Void) {
        
        apiService.performRequestPopularMovies(page: pagina, completion: { (result) in
            
            if result != nil{
                completion(result)
            }
            
        }, onError: {(error) in
            
            switch error{
            case .invalidJSON:
                print("JSON inválido")
            case .noData:
                print("Sem dados")
            case .noResponse:
                print("Sem resposta da API")
            case .erroResposta:
                print("Sem resposta da API")
            default:
                print("Erro genérico")
            }
            
        })
        
    }
    
    func getGenres(completion: @escaping (GenreModel?) -> Void) {
        
        apiService.performRequestGenres(completion: { (result) in
            
            if result != nil{
                completion(result)
            }
            
        }, onError: {(error) in
            
            switch error{
            case .invalidJSON:
                print("JSON inválido")
            case .noData:
                print("Sem dados")
            case .noResponse:
                print("Sem resposta da API")
            case .erroResposta:
                print("Sem resposta da API")
            default:
                print("Erro genérico")
            }
            
        })
        
    }
    
    func getSearchMovies(pagina: Int, movie: String, completion: @escaping ([MoviesModel]?) -> Void) {
        
        apiService.performRequestSearchMovies(page: pagina, movie: movie, completion: { (result) in
            
            if result != nil{
                completion(result)
            }
            
        }, onError: {(error) in
            
            switch error{
            case .invalidJSON:
                print("JSON inválido")
            case .noData:
                print("Sem dados")
            case .noResponse:
                print("Sem resposta da API")
            case .erroResposta:
                print("Sem resposta da API")
            default:
                print("Erro genérico")
            }
            
        })
        
    }
    
    func getFavoriteMovies(completion: @escaping ([MoviesModel]?) -> Void) {
        firebaseService.performGetFavoriteMovies(completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
    }
    
}
