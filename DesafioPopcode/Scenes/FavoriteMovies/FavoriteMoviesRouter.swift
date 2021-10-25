//
//  FavoriteMoviesRouter.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import UIKit

protocol FavoriteMoviesRoutingLogic{
    func routeToDetail(segue: UIStoryboardSegue?)
}

protocol FavoriteMoviesDataPassing{
    var dataStore: FavoriteMoviesDataStore? {get set}
}

class FavoriteMoviesRouter: NSObject, FavoriteMoviesRoutingLogic, FavoriteMoviesDataPassing {
    var dataStore: FavoriteMoviesDataStore?
    weak var viewController: FavoriteMoviesViewController?
    
    func routeToDetail(segue: UIStoryboardSegue?)
    {
      if let segue = segue {
        let destinationVC = segue.destination as! MovieDetailViewController
        var destinationData = destinationVC.router!.dataStore!
        passDataToDetailDataStore(movie: dataStore!, destination: &destinationData)
      } else {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetailDataStore(movie: dataStore!, destination: &destinationDS)
        navigateToDetailViewController(source: viewController!, destination: destinationVC)
      }
    }

    // MARK: - Navigation
    
    func navigateToDetailViewController(source: FavoriteMoviesViewController, destination: MovieDetailViewController)
    {
      source.show(destination, sender: nil)
    }
    
    // MARK: - Passing data
    
    func passDataToDetailDataStore(movie: FavoriteMoviesDataStore, destination: inout MovieDetailDataStore)
    {
        destination.movie = movie.movieDetailModel
        print("Teste")
    }
}
