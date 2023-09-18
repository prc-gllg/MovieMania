//
//  MovieDetail_ViewModel.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/18/23.
//

import Foundation

//MARK: - Movie Detail View Model

protocol MovieDetail_ViewModelProtocol: ObservableObject {
    var trackId: Int { get }
    var imageURL: URL? { get }
    var title: String { get }
    var plot: String { get }
    var genre: String { get }
    var price: String { get }
    var isFavorite: Bool { get }
    func toggleFavorite()
}

class MovieDetail_ViewModel: MovieDetail_ViewModelProtocol {
    
    @Published var trackId: Int
    @Published var imageURL: URL?
    @Published var title: String
    @Published var plot: String
    @Published var genre: String
    @Published var price: String
    @Published var isFavorite: Bool

    init(movie: MovieDetail) {
        self.trackId = movie.movie.trackId
        self.imageURL = URL(string: movie.movie.artworkUrl100 ?? "")
        self.title = movie.movie.trackName ?? "No title"
        self.plot = movie.movie.longDescription ?? ""
        self.genre = movie.movie.primaryGenreName ?? ""
        self.price = "\(movie.movie.currency ?? "") \(movie.movie.trackPrice ?? 0)"
        self.isFavorite = movie.isFavorite
    }

    //this function is being called from the MovieDetail_View view
    //it toggles the favorite variable which is being used to determine button state
    //this calls a function from the FavoriteMoviesManager to update the list
    
    func toggleFavorite() {
        print("#1 Toggle here in movie list cell")
        self.isFavorite.toggle()
        FavoriteMoviesManager.shared.updateFavoriteList(for: trackId)
    }
    
}
