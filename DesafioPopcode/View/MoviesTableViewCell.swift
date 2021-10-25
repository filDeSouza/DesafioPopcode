//
//  MoviesTableViewCell.swift
//  DesafioPopcode
//
//  Created by Filipe de Souza on 14/10/21.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    var movie: MoviesModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
