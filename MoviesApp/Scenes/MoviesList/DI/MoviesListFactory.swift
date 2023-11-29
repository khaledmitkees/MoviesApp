//
//  MoviesListFactory.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

class MoviesListFactory {
    static func makeMoviesListViewController() -> MoviesListViewController {

        let repository = MoviesListRepositoryImpl(remoteDataSource: AppDIFactory.apiDataTransferService)
        let useCase = GetMoviesListUseCaseImpl(repository: repository)
        let viewModel = MoviesListViewModel(moviesListUseCase: useCase)
        let viewController = MoviesListViewController.create(with: viewModel)
        
        return viewController
    }
    
    
}
