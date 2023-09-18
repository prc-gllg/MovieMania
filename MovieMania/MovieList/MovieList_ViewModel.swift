//
//  MovieList_ViewModel.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import Foundation

//MARK: - Movie List View Model

class MovieList_ViewModel: ObservableObject {
    @Published var movieList: [MovieDetail] = []
    @Published var favoriteMoviesList: [Int] = []
    private var favoriteMoviesManager: FavoriteMoviesManager
    
    //initialization
    init(favoriteMoviesManager: FavoriteMoviesManager) {
        self.favoriteMoviesManager = favoriteMoviesManager
    }
    //checks if this movie is set as a favorite
    func isMovieFavorite(movie: MovieFetchResult) -> Bool {
        return favoriteMoviesManager.favoriteMoviesList.contains { $0 == movie.trackId }
    }
    //fetch movies from the network manager (MovieListRequest)
    func fetchMovies() {
        MovieListRequest().fetchMovieListRequest { [self] result in
            switch result {
            case .success(let fetchResults):
                DispatchQueue.main.async {
                    print(fetchResults.results!)
                    self.movieList = []
                    if let results = fetchResults.results {
                        self.movieList = results.map({ result in
                            let isFavorite = self.isMovieFavorite(movie: result)
                            return MovieDetail(movie: result, isFavorite: isFavorite)
                        })
                    }
                }
            case .failure(let error):
                print("Error in fetching: \(error)")
            }
        }
    }
}
