//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

protocol MoviesListViewModelContract {
    func getMovies(completion: @escaping (Bool, Error?) -> Void)
}

final class MoviesListViewModel: MoviesListViewModelContract {
    
    let screenTitle = "Movies List"
    var page = 1
    var moviesList: [MoviesListDisplayModel] = []
    var numberOfMovies: Int { moviesList.count }
    
    private var moviesListUseCase: MoviesListUseCase
    private var moviesLoadTask: Cancellable? { willSet { moviesLoadTask?.cancel() } }
    
    init(moviesListUseCase: MoviesListUseCase) {
        self.moviesListUseCase = moviesListUseCase
    }
    
    func getMovies(completion: @escaping (Bool, Error?) -> Void) {
        moviesLoadTask = moviesListUseCase.execute(page: page) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.moviesList.append(contentsOf: response)
                completion(true, nil)
            case .failure(let error):
                self.moviesList = moviesListMock
                completion(false, error)
            }
        }
    }
}

let moviesListMock: [MoviesListDisplayModel] = [
    MoviesListDisplayModel(
        title: "Ant-Man and the Wasp: Quantumania",
        overview: "Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.",
        posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg"
    ),
    MoviesListDisplayModel(
        title: "The Super Mario Bros. Movie",
        overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
        posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg"
    ),
    // Add more movies as needed
]
