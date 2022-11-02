//
//  MovieViewController.swift
//  Movie App Rest API
//
//  Created by Jayden Kong on 29/10/2022.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.loadPopularMovieData(_:)), for: .valueChanged)
        tableView.backgroundView = refreshControl
        
        self.loadPopularMovieData(self)
        refreshControl.beginRefreshing()
    }
    
    @objc func loadPopularMovieData(_ sender: AnyObject) {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData{
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - TableView
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowsAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
    
}


extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: reloadData)
            { _ in completion() }
    }
}
