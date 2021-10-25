//
//  FirebaseService.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import UIKit
import Firebase

class FirebaseService{
    
    let db = Firestore.firestore()
    var movies: [MoviesModel] = []
    var deviceID: String?
    
    func performGetFavoriteMovies(completion: @escaping([MoviesModel]) -> Void){
        
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {return}
        
        db.collection(Constants.FStore.collectionName)
            .document(deviceID)
            .collection("favoritos")
            .addSnapshotListener{(querySnapshot, error) in
                
                if let e = error{
                    print("Erro ao carregar os dados do Firebase: \(e)")
                }else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        for doc in snapshotDocuments {
                            print(doc.data())
                            let data = doc.data()
                            if let movieID = data[Constants.FStore.movieID] as? Int, let movieTitle =  data[Constants.FStore.original_title] as? String, let movieGenre = data[Constants.FStore.genre_ids] as? [Int], let movieOverview = data[Constants.FStore.overview] as? String, let moviePoster = data[Constants.FStore.poster_path] as? String, let movieRelease = data[Constants.FStore.release_date] as? String{
                                
                                let newMovie = MoviesModel(genre_ids: movieGenre, id: movieID, original_title: movieTitle, overview: movieOverview, poster_path: moviePoster, release_date: movieRelease)
                                self.movies.append(newMovie)
                            }
                            
                        }
                        completion(self.movies)
                    }
                }
                
            }
        
        
    }
    
}
