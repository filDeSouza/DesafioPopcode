//
//  MovieDetailViewController.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 24/10/21.
//

import UIKit
import Firebase
import ProgressHUD

protocol MovieDetailDisplayLogic {
    func displayMovieDetail(movie: Detail.GetMovie.ViewModel)
    func displayGenres(genres: Detail.GetGenres.ViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic{

    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelDerscription: UILabel!
    
    var movie: MoviesModel?
    var genresModel: GenreModel?
    let utils = Utils()
    let db = Firestore.firestore()
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailDataPassing & DetailMoviesRoutingLogic)?
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGenres()
    }
    
    func setupGenres(){
        interactor?.getGenres(request: Detail.GetGenres.Request())
    }
    
    func setupDetailMovie() {
        interactor?.presentMovieDetail(request: Detail.GetMovie.Request())
    }
    
    // MARK: - Setup
    private func setup(){
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    func displayGenres(genres: Detail.GetGenres.ViewModel) {
        genresModel = genres.genres
        setupDetailMovie()
    }
    
    func displayMovieDetail(movie: Detail.GetMovie.ViewModel) {
        
        DispatchQueue.main.async {
            
            
            
            self.movie = movie.movie
            guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {return}
            
            guard let genresModelLet = self.genresModel else {return}
            guard let genresMovie = self.movie else {return}
            
            self.utils.compareGenreArrays(arrayGenresAPI: genresModelLet, arrayGenresMovie: genresMovie)
            
            if let poster = movie.movie.poster_path{
                self.utils.getImage(url: Constants.url_images + poster, imageView: self.imagePoster)
            }
            self.labelTitle.text = movie.movie.title
            if let date = movie.movie.release_date{
                self.labelYear.text = self.utils.formatacaoData(data: date)
            }
            
            
            if let description = movie.movie.overview{
                self.labelDerscription.text = description
            }
            
            self.db.collection(Constants.FStore.collectionName)
                .document(deviceID)
                .collection("favoritos")
                .addSnapshotListener{ (querySnapshot, error) in
                    if let e = error{
                        print("Erro ao carregar os dados do Firebase: \(e)")
                    }else{
                        if let snapshotDocuments = querySnapshot?.documents{
                            for doc in snapshotDocuments{
                                let data = doc.data()
                                let id: Int = data[Constants.FStore.movieID] as! Int
                                let stringID = movie.movie.id
                                print("Valor do ID do Firebase: \(id)")
                                print("Valor do ID do model: \(stringID)")
                                if stringID == id{
                                    self.buttonFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
                                    self.buttonFavorite.setBackgroundImage(UIImage(named: "favorite_full_icon"), for: .normal)
                                }
                            }
                        }
                    }
                }
        }
        
    }

    @IBAction func favoriteMovie(_ sender: UIButton) {
        
        ProgressHUD.show()
        
        guard let movieFB = movie else {return}
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {return}
        print("ID do dispositivo: \(deviceID)")
        
        if buttonFavorite.hasImage(named: "favorite_gray_icon", for: .normal){
            
            db.collection(Constants.FStore.collectionName).document(deviceID).collection("favoritos").document("\(movieFB.id)").setData([
                Constants.FStore.movieID: movieFB.id,
                Constants.FStore.original_title: movieFB.title,
                Constants.FStore.genre_ids: movieFB.genre_ids,
                Constants.FStore.overview: movieFB.overview ?? "",
                Constants.FStore.poster_path: movieFB.poster_path ?? "",
                Constants.FStore.release_date: movieFB.release_date ?? ""
            ]){(error) in
                    if let e = error{
                        print("Erro ao salvar dado no Firestore, \(e)")
                    }else{
                        self.buttonFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
                        self.buttonFavorite.setBackgroundImage(UIImage(named: "favorite_full_icon"), for: .normal)
                        ProgressHUD.dismiss()
                        print("Sucesso em salvar dados")
                    }
                }
            
        }else{
            db.collection(Constants.FStore.collectionName).document(deviceID).collection("favoritos").document("\(movieFB.id)").delete(){ err in
                
                if let err = err{
                    print("Erro ao remover o documento: \(err)")
                }else{
                    self.buttonFavorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
                    self.buttonFavorite.setBackgroundImage(UIImage(named: "favorite_gray_icon"), for: .normal)
                    ProgressHUD.dismiss()
                    print("Documento removido com sucesso")
                    
                    self.dismiss(animated: true, completion: nil)
                    self.router?.routeToFavorites(segue: nil)
                    
                }
            }
        }
        
    }
}
