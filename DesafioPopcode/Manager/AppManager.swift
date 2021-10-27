//
//  AppManager.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

class AppManager {
    
    let appBusiness = AppBusiness()
    
    func obtemPopularMovies(pagina: Int, completion: @escaping([MoviesModel]?) -> Void){
        
        appBusiness.obtemPopularMovies(pagina: pagina, completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
    func getSearchMovies(pagina: Int, movie: String, completion: @escaping([MoviesModel]?) -> Void){
        
        appBusiness.getSearchMovies(pagina: pagina, movie: movie, completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
    func getFavoriteMovies(completion: @escaping([MoviesModel]?) -> Void){
        
        appBusiness.getFavoriteMovies(completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
    func getGenres(completion: @escaping(GenreModel?) -> Void){
        
        appBusiness.getGenres(completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
    
}
