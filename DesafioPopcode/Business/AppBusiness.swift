//
//  AppBusiness.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

class AppBusiness {
    
    let provider = AppProvider()
    
    func obtemPopularMovies(pagina: Int, completion: @escaping([MoviesModel]?) -> Void){
        
        provider.obterPopularMovies(pagina: pagina, completion: {(result) in
            
            if result != nil{
                do{
                    let popularMovies = result
                    completion(popularMovies)
                }
            }else{
                return
            }
            
        })
        
    }
    
    func getSearchMovies(pagina: Int, movie: String, completion: @escaping([MoviesModel]?) -> Void){
        
        provider.getSearchMovies(pagina: pagina, movie: movie, completion: {(result) in
            
            if result != nil{
                do{
                    let popularMovies = result
                    completion(popularMovies)
                }
            }else{
                return
            }
            
        })
        
    }
    
    func getFavoriteMovies(completion: @escaping([MoviesModel]?) -> Void){
        
        provider.getFavoriteMovies(completion: {(result) in
            
            if result != nil{
                do{
                    let favoriteMovies = result
                    completion(favoriteMovies)
                }
            }else{
                return
            }
            
        })
        
    }
    
}
