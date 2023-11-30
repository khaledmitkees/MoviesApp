//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, StoryboardInstantiable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var movieBannerImageView: UIImageView!
    
    var viewModel: MovieDetailsViewModel?
    
    static func create(with viewModel: MovieDetailsViewModel) -> MovieDetailsViewController {
        let view = MovieDetailsViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getMovieDetails()
    }
    
    private func getMovieDetails() {
        viewModel?.getMovieDetails(completion: { [weak self] (success, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    self.updateView()
                } else {
                    //show alert
                }
            }
        })
    }
    
    private func updateView() {
        titleLabel.text = viewModel?.movieName
        overViewLabel.text = viewModel?.movieOverView
        
        let url = URL(string: viewModel?.getMovieImagePath(imageWidth: movieBannerImageView.closestImageWidth) ?? "")
        movieBannerImageView.kf.setImage(with: url, placeholder: UIImage(named: "MoviesPlaceholder"))
    }
    
    private func setupUI() {
        title = viewModel?.movie.title
        view.backgroundColor = .white
    }
}
