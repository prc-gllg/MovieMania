//
//  MovieListCell_ViewModel.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import Foundation
import SwiftUI

protocol MovieListCell_ViewModelProtocol: ObservableObject {
    var titleText: String { get }
    var genre: String { get }
    var price: String { get }
    var imageURL: URL? { get }
    var isFavorite: Bool { get }
    var movieId: Int { get }
    func toggleFavorite()
}

class MovieListCell_ViewModel: MovieListCell_ViewModelProtocol {
    
    @Published var titleText: String
    @Published var genre: String
    @Published var price: String
    @Published var imageURL: URL?
    @Published var isFavorite: Bool
    @Published var movieId: Int
    private var movieList_VM: MovieList_ViewModel
    
    init(movie: MovieDetail, movieList_VM: MovieList_ViewModel) {
        self.titleText = movie.movie.trackName ?? "No title"
        self.genre = movie.movie.primaryGenreName ?? "No genre"
        self.price = "\(movie.movie.currency ?? "") \(movie.movie.trackPrice ?? 0)"
        self.imageURL = URL(string: movie.movie.artworkUrl100 ?? "")
        self.isFavorite = movie.isFavorite
        self.movieId = movie.movie.trackId
        self.movieList_VM = movieList_VM
        
    }
    
    func toggleFavorite() {
        print("#1 Toggle here in movie list cell")
        self.isFavorite.toggle()
//        self.movieList_VM.toggleFavorite(for: movieId)
    }
}
