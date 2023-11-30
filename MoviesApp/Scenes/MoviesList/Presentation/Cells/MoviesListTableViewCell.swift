//
//  MoviesListTableViewCell.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import UIKit
import Kingfisher

class MoviesListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: MoviesListTableViewCell.self)
    static let height = CGFloat(120)

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverView: UILabel!
    

    func configure(with movie: MoviesListDisplayModel) {
        movieTitle.text = movie.title
        movieOverView.text = movie.overview
        
        let url = URL(string: "\(AppDIFactory.appConfiguration.apiBaseURL)\(movieImageView.closestImageWidth)\(movie.posterPath)")
        movieImageView.kf.setImage(with: url, placeholder: UIImage(named: "MoviesPlaceholder"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieTitle.text = nil
        movieOverView.text = nil
    }
    
}
