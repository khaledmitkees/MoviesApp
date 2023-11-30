//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

protocol MoviesDetailsViewModelContract {
    func getMovieDetails(completion: @escaping (Bool, Error?) -> Void)
}

class MovieDetailsViewModel: MoviesDetailsViewModelContract {
    
    var movieName = ""
    var movieOverView = ""
    let movie: MoviesDisplayModel
    private var response: MovieDetailsResponse? {
        didSet {
            movieName = response?.title ?? movie.title
            movieOverView = response?.overview ?? movie.overview
        }
    }
    private let useCase: GetMovieDetailsUseCase
    private var detailsLoadTask: Cancellable? { willSet { detailsLoadTask?.cancel() } }
    
    init(movie: MoviesDisplayModel, useCase: GetMovieDetailsUseCase) {
        self.movie = movie
        self.useCase = useCase
    }
    
    func getMovieDetails(completion: @escaping (Bool, Error?) -> Void) {
        detailsLoadTask = useCase.execute(movieId: movie.id) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.response = response
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func getMovieImagePath(imageWidth: Int) -> String {
        let path = "\(AppDIFactory.appConfiguration.apiBaseURL)\(imageWidth)\(movie.posterPath)"
        return path
    }
}
