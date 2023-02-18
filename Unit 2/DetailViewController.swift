//
//  DetailViewController.swift
//  Unit 2
//
//  Created by Benjamin Hoesli on 11.02.23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    var movie: Movie!

    @IBOutlet weak var movieVotes: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var moviePopularity: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Load the image located at the `artworkUrl100` URL and set it on the image view.
       Nuke.loadImage(with: URL(string:"https://image.tmdb.org/t/p/w185" + movie.poster_path)!, into: movieImageView)

        //Set labels with the associated track values.

        movieRating.text=String(movie.vote_average)+" Vote Average"
        movieVotes.text=String(movie.vote_count)+" Votes"
        movieDescription.text=movie.overview
        movieNameLabel.text=movie.original_title
        moviePopularity.text=String(movie.popularity) + " Popularity"
        
    
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }

}
