//
//  MovieCell.swift
//  Unit 2
//
//  Created by Benjamin Hoesli on 10.02.23.
//

import UIKit
import Nuke





class MovieCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descriptionNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    /// Configures the cell's UI for the given track.
    func configure(with movie: Movie) {
        movieNameLabel.text = movie.original_title
        descriptionNameLabel.text = movie.overview

        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: URL(string:"https://image.tmdb.org/t/p/w185" + movie.poster_path)!, into: movieImageView)
    }
}
