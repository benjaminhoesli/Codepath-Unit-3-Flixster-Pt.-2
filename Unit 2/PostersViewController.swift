//
//  PostersViewController.swift
//  Unit 2
//
//  Created by Benjamin Hoesli on 17.02.23.
//

import UIKit
import Nuke


struct PostersSearchResponse: Decodable {
    let results: [Poster]
}

struct Poster: Decodable {
    let poster_path: String
}

class PostersViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a collection view cell (based in the identifier you set in storyboard) and cast it to our custom AlbumCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell

        // Use the indexPath.item to index into the albums array to get the corresponding album
        let poster = posters[indexPath.item]


        // Set the image on the image view of the cell
        Nuke.loadImage(with: URL(string:"https://image.tmdb.org/t/p/w185" + poster.poster_path)!, into: cell.posterImageView)

        return cell
    }
    
    var posters: [Movie] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        let look = UINavigationBarAppearance()
        look.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        look.titleTextAttributes = [.foregroundColor: UIColor.white]
            
        collectionView.dataSource = self
        // Create a search URL for fetching albums (`entity=album`)
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=8bc5aee3a2f96bb21c4b2e4482c85ead")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            // Handle any errors
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }

            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }

            let decoder = JSONDecoder()
            do {
                // Try to parse the response into our custom model
                let response = try decoder.decode(MoviesResponse.self, from: data)
                let posters = response.results
                DispatchQueue.main.async{
                    self?.posters = posters
                    self?.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }

        // Initiate the network request
        task.resume()

        // Do any additional setup after loading the view.
        // Get a reference to the collection view's layout
        // We want to dynamically size the cells for the available space and desired number of columns.
        // NOTE: This collection view scrolls vertically, but collection views can alternatively scroll horizontally.
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        // The minimum spacing between adjacent cells (left / right, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumInteritemSpacing = 4

        // The minimum spacing between adjacent cells (top / bottom, in vertical scrolling collection)
        // Set this to taste.
        layout.minimumLineSpacing = 4

        // Set this to however many columns you want to show in the collection.
        let numberOfColumns: CGFloat = 3

        // Calculate the width each cell need to be to fit the number of columns, taking into account the spacing between cells.
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns

        // Set the size that each tem/cell should display at
        layout.itemSize = CGSize(width: width, height: width)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
           let indexPath = collectionView.indexPath(for: cell),
           let detailViewController = segue.destination as? DetailViewController {
            let poster = posters[indexPath.row]
            detailViewController.movie = poster
        }
    }
    

}
