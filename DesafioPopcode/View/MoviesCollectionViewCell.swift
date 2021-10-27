//
//  MoviesCollectionViewCell.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 14/10/21.
//

import UIKit
import Firebase
import ProgressHUD

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let db = Firestore.firestore()
    var movie: MoviesModel?
    var deviceID: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        guard let movieFB = movie else {return}
        let docRef = db.collection(Constants.FStore.collectionName).document("\(movieFB.id)")
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists{
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            }else{
                print("Documento não localizado")
            }
            
        }
        
    }
    
    func setupFavoritos(movie: MoviesModel?){
        
        guard let movieFB = movie else {return}
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {return}
        
        db.collection(Constants.FStore.collectionName)
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
                            let stringID = movieFB.id
                            print("Valor do ID do Firebase: \(id)")
                            print("Valor do ID do model: \(stringID)")
                            if stringID == id{
                                print("Valor do ID do model é igual ao Firebase: \(stringID)")
                                self.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
                            }
                        }
                    }
                }
            }
    }

    @IBAction func favoriteButtonAction(_ sender: UIButton) {
        
        ProgressHUD.show()
        
        guard let movieFB = movie else {return}
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {return}
        print("ID do dispositivo: \(deviceID)")
        
        if favoriteButton.hasImage(named: "favorite_gray_icon", for: .normal){
            
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
                        self.favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
                        ProgressHUD.dismiss()
                        print("Sucesso em salvar dados")
                    }
                }
            
        }else{
            db.collection(Constants.FStore.collectionName).document(deviceID).collection("favoritos").document("\(movieFB.id)").delete(){ err in
                
                if let err = err{
                    print("Erro ao remover o documento: \(err)")
                }else{
                    self.favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
                    ProgressHUD.dismiss()
                    print("Documento removido com sucesso")
                }
            }
        }
        
    }
    
}
