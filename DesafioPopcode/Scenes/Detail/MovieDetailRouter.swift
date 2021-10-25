//
//  MovieDetailRouter.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 24/10/21.
//

import UIKit

protocol DetailMoviesRoutingLogic{
    func routeToFavorites(segue: UIStoryboardSegue?)
}

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? {get}
}

class MovieDetailRouter: NSObject, MovieDetailDataPassing, DetailMoviesRoutingLogic{

    weak var viewController: MovieDetailViewController?
    var dataStore: MovieDetailDataStore?

    func routeToFavorites(segue: UIStoryboardSegue?) {
        
        if let segue = segue {
          let destinationVC = segue.destination as! FavoriteMoviesViewController
          navigateToDetailViewController(source: viewController!, destination: destinationVC)
        } else {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let destinationVC = storyboard.instantiateViewController(withIdentifier: "FavoriteMoviesViewController") as! FavoriteMoviesViewController
          navigateToDetailViewController(source: viewController!, destination: destinationVC)
        }
        
    }
    
    // MARK: - Navigation
    
    func navigateToDetailViewController(source: MovieDetailViewController, destination: FavoriteMoviesViewController)
    {
      source.show(destination, sender: nil)
    }
    
}
