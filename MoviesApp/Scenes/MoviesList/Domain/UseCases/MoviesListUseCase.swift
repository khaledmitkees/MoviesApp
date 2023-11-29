//
//  MoviesListUseCase.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

protocol MoviesListUseCase {
    func execute()
}

final class GetMoviesListUseCaseImpl: MoviesListUseCase {
    private let repository: MoviesListRepository
    
    init(repository: MoviesListRepository) {
        self.repository = repository
    }
    
    func execute() {
        
    }
}
