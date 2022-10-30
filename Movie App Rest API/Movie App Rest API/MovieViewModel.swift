//
//  MovieViewModel.swift
//  Movie App Rest API
//
//  Created by Jayden Kong on 30/10/2022.
//

import Foundation

class MovieViewModel {
    
    private var apiService = ApiService()
    private var popularMovies = [Movie]()
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        
        apiService.getPopularMoviesData{ [weak self] (result) in
            
            switch result {
            case.success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowsAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
    
}
