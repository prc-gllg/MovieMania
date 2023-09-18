//
//  FavoriteMovies_ViewModel.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/18/23.
//

import Foundation


//MARK: - Favorite Movies List View Model

//protocol FavoriteMovies_ViewModelProtocol: ObservableObject {
//    var favoriteMovieList: [MovieDetail] { get }
//    func isMovieFavorite(movie: MovieFetchResult) -> Bool
//    func fetchFavoriteMovies()
//}
//
//class FavoriteMovies_ViewModel: FavoriteMovies_ViewModelProtocol {
//    @Published var id = UUID()
//    @Published var favoriteMovieList: [MovieDetail] = []
//    private var favoriteMoviesManager: FavoriteMoviesManager
//
//    //initialization
//    init(favoriteMoviesManager: FavoriteMoviesManager) {
//        self.favoriteMoviesManager = favoriteMoviesManager
//    }
//    //checks if this movie is set as a favorite
//    func isMovieFavorite(movie: MovieFetchResult) -> Bool {
//        return favoriteMoviesManager.favoriteMoviesList.contains { $0 == movie.trackId }
//    }
//    //fetch movies from the network manager (MovieListRequest) but filter in the results and only return the movies set as favorite based on the favorite list
//    func fetchFavoriteMovies() {
//        MovieListRequest().fetchMovieListRequest { [self] result in
//            switch result {
//            case .success(let fetchResults):
//                DispatchQueue.main.async {
//                    print(fetchResults.results!)
//                    self.favoriteMovieList = []
//                    if let results = fetchResults.results {
//                        self.favoriteMovieList = results
//                            .filter { result in
//                                print(self.favoriteMoviesManager.favoriteMoviesList)
//                                return self.favoriteMoviesManager.favoriteMoviesList.contains(result.trackId)
//                            }
//                            .map { result in
//                                let isFavorite = self.isMovieFavorite(movie: result)
//                                return MovieDetail(movie: result, isFavorite: isFavorite)
//                            }
//                    }
//                }
//            case .failure(let error):
//                print("Error in fetching: \(error)")
//            }
//        }
//    }
//
//}


protocol FavoriteMovies_ViewModelProtocol: ObservableObject {
    var favoriteMovieList: [MovieDetail] { get }
    func isMovieFavorite(movie: MovieFetchResult) -> Bool
    func fetchFavoriteMovies()
}

class FavoriteMovies_ViewModel: FavoriteMovies_ViewModelProtocol {
    @Published var id = UUID()
    @Published var favoriteMovieList: [MovieDetail] = []
    private var favoriteMoviesManager: FavoriteMoviesManager
    
    //initialization
    init(favoriteMoviesManager: FavoriteMoviesManager) {
        self.favoriteMoviesManager = favoriteMoviesManager
    }
    //checks if this movie is set as a favorite
    func isMovieFavorite(movie: MovieFetchResult) -> Bool {
        return favoriteMoviesManager.favoriteMoviesList.contains { $0 == movie.trackId }
    }
    //fetch movies from the network manager (MovieListRequest) but filter in the results and only return the movies set as favorite based on the favorite list
    func fetchFavoriteMovies() {
        MovieListRequest().fetchMovieListRequest { [self] result in
            switch result {
            case .success(let fetchResults):
                DispatchQueue.main.async {
                    print(fetchResults.results!)
                    self.favoriteMovieList = []
                    if let results = fetchResults.results {
                        self.favoriteMovieList = results
                            .filter { result in
                                print(self.favoriteMoviesManager.favoriteMoviesList)
                                return self.favoriteMoviesManager.favoriteMoviesList.contains(result.trackId)
                            }
                            .map { result in
                                let isFavorite = self.isMovieFavorite(movie: result)
                                return MovieDetail(movie: result, isFavorite: isFavorite)
                            }
                    }
                }
            case .failure(let error):
                print("Error in fetching: \(error)")
            }
        }
    }
    
}
