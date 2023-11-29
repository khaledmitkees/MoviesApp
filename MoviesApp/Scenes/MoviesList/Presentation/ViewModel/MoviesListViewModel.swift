//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

protocol MoviesListViewModelContract {
    func getMovies()
}

final class MoviesListViewModel: MoviesListViewModelContract {
    var moviesListUseCase: MoviesListUseCase
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    
    init(moviesListUseCase: MoviesListUseCase) {
        self.moviesListUseCase = moviesListUseCase
    }
        
    func getMovies() {
        moviesLoadTask = moviesListUseCase.execute(page: 1) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
