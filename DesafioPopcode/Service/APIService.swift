//
//  APIService.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 14/10/21.
//

import Foundation

enum APIError{
    case url
    case taskError
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
    case erroResposta
}

class APIService{
    
    func performRequestPopularMovies(page: Int, completion: @escaping([MoviesModel]) -> Void, onError: @escaping(APIError) -> Void){
        
        let urlString = Constants.base_url + Constants.endpoint_popular_movie + Constants.api_key + Constants.page + "\(page)"
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlString) else{
            onError(.url)
            return
        }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            if error != nil{
                onError(.taskError)
                return
            }
            guard let response = response as? HTTPURLResponse else{
                onError(.erroResposta)
                return
            }
            if response.statusCode == 200{
                guard let data = data else{
                    onError(.noData)
                    return
                }
                do {
                    let movie = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(movie.results)
                } catch {
                    onError(.invalidJSON)
                }
            }else{
                onError(.noResponse)
            }
            
        })
        task.resume()
    }
    
    func performRequestSearchMovies(page: Int, movie: String, completion: @escaping([MoviesModel]) -> Void, onError: @escaping(APIError) -> Void){
        
        let urlString = Constants.base_url + Constants.endpoint_search + Constants.api_key + Constants.query + movie + Constants.page + "\(page)"
        let session = URLSession(configuration: .default)
        guard let url = URL(string: urlString) else{
            onError(.url)
            return
        }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            //print(data!)
            if error != nil{
                onError(.taskError)
                return
            }
            guard let response = response as? HTTPURLResponse else{
                onError(.erroResposta)
                return
            }
            if response.statusCode == 200{
                guard let data = data else{
                    onError(.noData)
                    return
                }
                do {
                    let movie = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(movie.results)
                } catch {
                    onError(.invalidJSON)
                }
            }else{
                onError(.noResponse)
            }
            
        })
        task.resume()
        
    }
    
}
