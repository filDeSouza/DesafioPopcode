//
//  FavoriteMoviesWorker.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import UIKit

class FavoriteMoviesWorker{
    
    let appManager = AppManager()
    
    func fetchFavoriteMovies(completion: @escaping([MoviesModel]?) -> Void){
        
        appManager.getFavoriteMovies(completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
}
