//
//  ViewController.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 14/10/21.
//

import UIKit
import ProgressHUD

protocol PopularMoviesDisplayLogic {
    func displayPopularMovies(viewModel: PopularMovies.Acao.ViewModel)
    func displaySearchMovies(viewModel: PopularMovies.Acao.ViewModel)
    func displayMovieDetail(viewModel: PopularMovies.Acao.ViewModelDetail)
}

class PopularMoviesViewController: UIViewController, PopularMoviesDisplayLogic {
    
    var popularMovies: [MoviesModel] = []
    var interactor: PopularMoviesBusinessLogic?
    var router: (NSObjectProtocol & PopularMoviesDataPassing & PopularMoviesRoutingLogic)?
    var pagina = 1
    var totalPaginas = 500
    var utils = Utils()
    var isPageRefreshing:Bool = false
    
    var searchMovies: [MoviesModel] = []
    var search = 0
    var numberOfItens = 0
    var movieSearch: String?

    
    @IBOutlet weak var collectionViewPopularMovies: UICollectionView!
    

    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.sizeToFit()
        navigationItem.searchController?.searchBar.placeholder = "Digite o filme"
        navigationItem.searchController?.searchBar.delegate = self
        
        collectionViewPopularMovies.dataSource = self
        collectionViewPopularMovies.delegate = self
        
        collectionViewPopularMovies.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellWithReuseIdentifier: Constants.cellIdentifier)
        
        obtemPopularMovies(pagina: pagina)
    }
    
    func obtemPopularMovies(pagina: Int){
        interactor?.popularMoviesRealizaRequest(pagina: pagina, request: PopularMovies.Acao.Request())
    }
    
    func getSearchMovies(pagina: Int, movie: String){
        interactor?.popularSearchRequest(pagina: pagina, movie: movie, request: PopularMovies.Acao.Request())
    }

    // MARK: - Setup
    private func setup(){
        let viewController = self
        let interactor = PopularMoviesInteractor()
        let presenter = PopularMoviesPresenter()
        let router = PopularMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    func displayPopularMovies(viewModel: PopularMovies.Acao.ViewModel) {
        DispatchQueue.main.async {
            self.popularMovies.append(contentsOf: viewModel.popularMovies)
            ProgressHUD.dismiss()
            self.collectionViewPopularMovies.reloadData()
        }
    }
    
    func displaySearchMovies(viewModel: PopularMovies.Acao.ViewModel) {
        DispatchQueue.main.async {
            self.searchMovies.append(contentsOf: viewModel.popularMovies)
            ProgressHUD.dismiss()
            self.collectionViewPopularMovies.reloadData()
        }
    }
    
    func displayMovieDetail(viewModel: PopularMovies.Acao.ViewModelDetail) {
        router?.dataStore?.movieDetailModel = viewModel.detailMovie
        router?.routeToDetail(segue: nil)
    }

}

extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if search == 0 {
            numberOfItens = popularMovies.count
        }else{
            numberOfItens = searchMovies.count
        }
        
        return numberOfItens
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewPopularMovies.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! MoviesCollectionViewCell
        
        var movies: [MoviesModel] = []
        
        if search == 0 {
            movies = popularMovies
        }else{
            movies = searchMovies
        }

        cell.movie = movies[indexPath.row]
        utils.popularCelulaPopularMovies(movies, cell, indexPath)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        
        let spacing: CGFloat = 6
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth * 1.65)
        
        return itemSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionViewPopularMovies.contentOffset.y >= (collectionViewPopularMovies.contentSize.height - collectionViewPopularMovies.bounds.size.height) {
            if !isPageRefreshing{
                isPageRefreshing = true
                pagina += 1
                obtemPopularMovies(pagina: pagina)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if pagina <= totalPaginas {
            if search == 0 {
                if indexPath.row == (popularMovies.count) - 1{
                    pagina += 1
                    obtemPopularMovies(pagina: pagina)
                }
            }else{
                if indexPath.row == (searchMovies.count) - 1{
                    pagina += 1
                    if let valorSearchMovie = movieSearch {
                        getSearchMovies(pagina: pagina, movie: valorSearchMovie)
                        obtemPopularMovies(pagina: pagina)
                    }

                }
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if search == 0 {
            interactor?.displayMovieDetail(movie: popularMovies[indexPath.row])

        }else{
            interactor?.displayMovieDetail(movie: searchMovies[indexPath.row])
        }
        
    }
    
}

extension PopularMoviesViewController: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {

        print("Valor do SearchBar: \(searchBar.text!)")
        search = 1
        if let movie = searchBar.text{
            ProgressHUD.show()
            pagina = 1
            movieSearch = movie
            getSearchMovies(pagina: pagina, movie: movie)
        }
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        if searchBar.text != "" {
            return true
        }else{
            search = 0
            searchBar.placeholder = "Digite a galeria desejada"
            collectionViewPopularMovies.reloadData()
            return false
        }
        
    }
    
}
