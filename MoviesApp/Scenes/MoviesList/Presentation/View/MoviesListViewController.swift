//
//  MoviesListViewController.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import UIKit

final class MoviesListViewController: UIViewController, StoryboardInstantiable {
    
    var viewModel: MoviesListViewModel?
    
    static func create(with viewModel: MoviesListViewModel) -> MoviesListViewController {
        let view = MoviesListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
