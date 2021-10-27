//
//  MovieDetailWorker.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 26/10/21.
//

import UIKit

class MovieDetailWorker {
    
    let appManager = AppManager()
    
    func fetchGenres(completion: @escaping(GenreModel?) -> Void){
        
        appManager.getGenres(completion: { (result) in
            
            if result != nil{
                completion(result)
            }else{
                return
            }
            
        })
        
    }
    
}
