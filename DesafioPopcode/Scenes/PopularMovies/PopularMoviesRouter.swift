//
//  PopularMoviesRouter.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

protocol PopularMoviesRoutingLogic{
    func routeToDetail(segue: UIStoryboardSegue?)
}

protocol PopularMoviesDataPassing {
    var dataStore: PopularMoviesDataStore? {get set}
}

class PopularMoviesRouter: NSObject, PopularMoviesRoutingLogic, PopularMoviesDataPassing {
    
    var dataStore: PopularMoviesDataStore?
    weak var viewController: PopularMoviesViewController?
    
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
    
    func navigateToDetailViewController(source: PopularMoviesViewController, destination: MovieDetailViewController)
    {
      source.show(destination, sender: nil)
    }
    
    // MARK: - Passing data
    
    func passDataToDetailDataStore(movie: PopularMoviesDataStore, destination: inout MovieDetailDataStore)
    {
        destination.movie = movie.movieDetailModel
        print("Teste")
    }
    
}
