//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import UIKit

final class MoviesListViewController: UIViewController, StoryboardInstantiable {
    
    var viewModel: MoviesListViewModel?
    private var moviesListTableView = UITableView()
    
    static func create(with viewModel: MoviesListViewModel) -> MoviesListViewController {
        let view = MoviesListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        getMoviesList()
    }
    
    private func getMoviesList() {
        viewModel?.getMovies(completion: { [weak self] (success, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if success {
                    self.moviesListTableView.reloadData()
                } else {
                    //show alert
                    self.moviesListTableView.reloadData()
                }
            }
           
        })
    }
    
    // MARK: - Setup UI Methods
        
    private func setupUI() {
        title = viewModel?.screenTitle
    }
    
    private func setupTableView() {
        moviesListTableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        view.addSubview(moviesListTableView)
        moviesListTableView.register(UINib(nibName: MoviesListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MoviesListTableViewCell.reuseIdentifier)
        moviesListTableView.dataSource = self
        moviesListTableView.delegate = self
        moviesListTableView.estimatedRowHeight = MoviesListTableViewCell.height
        moviesListTableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfMovies ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesListTableView.dequeueReusableCell(withIdentifier: MoviesListTableViewCell.reuseIdentifier, for: indexPath) as? MoviesListTableViewCell,
              let viewModel = viewModel
        else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.moviesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        guard let viewModel = viewModel else { return }
        let vc = MoviesDetailsFactory.makeMovieDetailsViewController(movie: viewModel.moviesList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

