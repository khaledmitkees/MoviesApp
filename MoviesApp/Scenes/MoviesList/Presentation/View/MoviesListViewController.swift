//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import UIKit

final class MoviesListViewController: UIViewController, StoryboardInstantiable {
    
    var viewModel: MoviesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        title = "Movies List"
    }
}
