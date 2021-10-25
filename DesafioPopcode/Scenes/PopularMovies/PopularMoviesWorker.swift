//
//  PopularMoviesWorker.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

class PopularMoviesWorker {
    
    let appManager = AppManager()
    
    func fetchPopularMovies(pagina: Int, completion: @escaping([MoviesModel]?) -> Void){
        
        appManager.obtemPopularMovies(pagina: pagina, completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
    func fetchSearchMovies(pagina: Int, movie: String, completion: @escaping([MoviesModel]?) -> Void){
        
        appManager.getSearchMovies(pagina: pagina, movie: movie, completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
}

