//
//  MovieListCell_ViewModel.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import Foundation
import SwiftUI

//MARK: - Movie List Cell View Model

protocol MovieListCell_ViewModelProtocol: ObservableObject {
    var titleText: String { get }
    var genre: String { get }
    var price: String { get }
    var imageURL: URL? { get }
    var isFavorite: Bool { get }
    var trackId: Int { get }
    func toggleFavorite()
}

class MovieListCell_ViewModel: MovieListCell_ViewModelProtocol {
    
    @Published var titleText: String
    @Published var genre: String
    @Published var price: String
    @Published var imageURL: URL?
    @Published var isFavorite: Bool
    @Published var trackId: Int
    
    init(movie: MovieDetail) {
        self.titleText = movie.movie.trackName ?? "No title"
        self.genre = movie.movie.primaryGenreName ?? "No genre"
        self.price = "\(movie.movie.currency ?? "") \(movie.movie.trackPrice ?? 0)"
        self.imageURL = URL(string: movie.movie.artworkUrl100 ?? "")
        self.isFavorite = movie.isFavorite
        self.trackId = movie.movie.trackId
    }
    
    //this function is being called from the MovieListCell view
    //it toggles the favorite variable which is being used to determine button state
    //this calls a function from the FavoriteMoviesManager to update the list
    func toggleFavorite() {
        print("#1 Toggle here in movie list cell")
        self.isFavorite.toggle()
        FavoriteMoviesManager.shared.updateFavoriteList(for: trackId)
    }
}
