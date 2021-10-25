//
//  FavoriteMoviesViewController.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 22/10/21.
//

import UIKit

protocol FavoriteMoviesDisplayLogic {
    func displayFavoriteMovies(viewModel: FavoriteMovies.Acao.ViewModel)
    func displayMovieDetail(viewModel: FavoriteMovies.Acao.ViewModelDetail)
}

class FavoriteMoviesViewController: UIViewController, FavoriteMoviesDisplayLogic {

    @IBOutlet weak var tableView: UITableView!
    
    var favoriteMovies: [MoviesModel] = []
    var interactor: FavoriteMoviesBusinessLogic?
    var router: (NSObjectProtocol & FavoriteMoviesDataPassing & FavoriteMoviesRoutingLogic)?
    var utils = Utils()
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        favoriteMovies = []

        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.sizeToFit()
        navigationItem.searchController?.searchBar.placeholder = "Digite o filme"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: Constants.cellFavoriteMoviesNibName, bundle: nil), forCellReuseIdentifier: Constants.cellFavoriteMoviesIdentifier)
        
        getFavoriteMovies()
        
    }
    
    func getFavoriteMovies(){
        interactor?.favoriteMoviesRealizaRequest(request: FavoriteMovies.Acao.Request())
    }
    
    private func setup(){
        let viewController = self
        let interactor = FavoriteMoviesInteractor()
        let presenter = FavoriteMoviesPresenter()
        let router = FavoriteMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func displayFavoriteMovies(viewModel: FavoriteMovies.Acao.ViewModel) {
        DispatchQueue.main.async {
            self.favoriteMovies = viewModel.favoriteMovies
            self.tableView.reloadData()
        }
    }
    
    func displayMovieDetail(viewModel: FavoriteMovies.Acao.ViewModelDetail) {
        router?.dataStore?.movieDetailModel = viewModel.detailMovie
        router?.routeToDetail(segue: nil)
    }

}

extension FavoriteMoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //guard let favoriteMoviesPopulado = favoriteMovies else{return 0}
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellFavoriteMoviesIdentifier, for: indexPath) as! MoviesTableViewCell
        let movies = favoriteMovies
        cell.movie = movies[indexPath.row]
        utils.popularCelulaFavoriteMovies(movies, cell, indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.displayMovieDetail(movie: favoriteMovies[indexPath.row])
    }
    
}
