//
//  MovieDetailsFactory.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

class MoviesDetailsFactory {
    static func makeMovieDetailsViewController(movie: MoviesDisplayModel) -> MovieDetailsViewController {

        let repository = MovieDetailsRepositoryImpl(remoteDataSource: AppDIFactory.apiDataTransferService)
        let useCase = GetMovieDetailsUseCaseImpl(repository: repository)
        let viewModel = MovieDetailsViewModel(movie: movie, useCase: useCase)
                
        let viewController = MovieDetailsViewController.create(with: viewModel)
                
        return viewController
    }
    
    
}
