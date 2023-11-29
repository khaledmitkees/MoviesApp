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
    
    init(moviesListUseCase: MoviesListUseCase) {
        self.moviesListUseCase = moviesListUseCase
    }
        
    func getMovies() {
        
    }
}
