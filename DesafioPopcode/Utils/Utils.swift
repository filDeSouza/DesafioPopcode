//
//  Utils.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 15/10/21.
//

import UIKit

class Utils {
    
    func popularCelulaPopularMovies(_ popularMovies: [MoviesModel],_ cell: MoviesCollectionViewCell, _ indexPath: IndexPath){
        cell.labelMovieTitle.text = popularMovies[indexPath.row].title
        
        if let poster = popularMovies[indexPath.row].poster_path{
            guard let url = URL(string: Constants.url_images + poster) else {return}
            getData(from: url) { data, response, error in

                if error != nil{
                    DispatchQueue.main.async {
                        cell.imageViewMovie.image = UIImage(named: "Logomarca_Sicredi")
                        print("erro ao carregar imagem")
                    }
                }else{
                    guard let data = data else {return}
                    guard let response = response as? HTTPURLResponse else{
                        return
                    }
                    if response.statusCode == 404 {
                        DispatchQueue.main.async {
                            cell.imageViewMovie.image = UIImage(named: "Logomarca_Sicredi")
                            print("erro ao carregar imagem")
                        }
                    }else{
                        DispatchQueue.main.async() { [weak self] in
                        cell.imageViewMovie?.image = UIImage(data: data)
                    }
                    }
                }
            }
        }
        
        cell.setupFavoritos(movie: popularMovies[indexPath.row])
    }
    
    func popularCelulaFavoriteMovies(_ favoriteMovies: [MoviesModel],_ cell: MoviesTableViewCell, _ indexPath: IndexPath){
        cell.labelMovieTitle.text = favoriteMovies[indexPath.row].title
        
        cell.labelMovieDescription.text = favoriteMovies[indexPath.row].overview
        
        if let movieDate = favoriteMovies[indexPath.row].release_date{
            cell.labelMovieYear.text = formatacaoData(data: movieDate)
        }

        if let poster = favoriteMovies[indexPath.row].poster_path{
            guard let url = URL(string: Constants.url_images + poster) else {return}
            
            getData(from: url) { data, response, error in

                if error != nil{
                    DispatchQueue.main.async {
                        cell.imageMovie.image = UIImage(named: "Logomarca_Sicredi")
                        print("erro ao carregar imagem")
                    }
                }else{
                    guard let data = data else {return}
                    guard let response = response as? HTTPURLResponse else{
                        return
                    }
                    
                    if response.statusCode == 404 {
                        DispatchQueue.main.async {
                            cell.imageMovie.image = UIImage(named: "Logomarca_Sicredi")
                            print("erro ao carregar imagem")
                        }
                    }else{
                        DispatchQueue.main.async() { [weak self] in
                        cell.imageMovie?.image = UIImage(data: data)
                    }
                    
                    }
                }
            }
        }
    }
    
    //MARK: - Obter dados da imagem
    func getImage(url: String, imageView: UIImageView){
        
        guard let url = URL(string: url) else {return}
        
        getData(from: url) { data, response, error in
            if error != nil{
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "Logomarca_Sicredi")
                }
            }else{
                guard let data = data else {return}
                guard let response = response as? HTTPURLResponse else{
                    return
                }
                
                if response.statusCode == 404 {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(named: "Logomarca_Sicredi")
                    }
                }else{
                    DispatchQueue.main.async() { [weak self] in
                        imageView.image = UIImage(data: data)
                }
                
                }
        }
        
    }
    }
    
    func formatacaoData(data: String) -> String{
        
        let dataCompleta = (data.index(data.startIndex, offsetBy: 4))
        let data = (data.prefix(upTo: dataCompleta))
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        let date: Date = dateFormatterGet.date(from: String(data))!
        return dateFormatterPrint.string(from: date)
        
    }
    
    //MARK: - Obter valor da imagem por meio da URLSession
    func getData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func compareGenreArrays(arrayGenresAPI: GenreModel, arrayGenresMovie: MoviesModel) -> Array<Any>{
        let listGenres = arrayGenresAPI.genres.contains(where: arrayGenresMovie.genre_ids)
    }
    
}

extension UIButton {
    func hasImage(named imageName: String, for state: UIControl.State) -> Bool {
        guard let buttonImage = image(for: state), let namedImage = UIImage(named: imageName) else {
            return false
        }

        return buttonImage.pngData() == namedImage.pngData()
    }
}

public extension Sequence where Element : Hashable {
    func contains(_ elements: [Element]) -> Bool {
        return Set(elements).isSubset(of:Set(self))
    }
}
