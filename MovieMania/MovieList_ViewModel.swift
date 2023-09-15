//
//  MovieList_ViewModel.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import Foundation


class MovieList_ViewModel: ObservableObject {
    @Published var movieList: [MovieDetail] = []
    @Published var favoriteMoviesList: [Int] = [978943481, 975080816, 1128456722]
    
    func isMovieFavorite(movie: MovieFetchResult) -> Bool {
        return favoriteMoviesList.contains { $0 == movie.trackId }
    }
    
    func toggleFavorite(for movieId: Int) {
        print("#2 Favorite is toggled here")
        if let index = favoriteMoviesList.firstIndex(where: { $0 == movieId}) {
            favoriteMoviesList.remove(at: index)
        } else {
            favoriteMoviesList.append(movieId)
        }
        print(favoriteMoviesList)
    }
    
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
