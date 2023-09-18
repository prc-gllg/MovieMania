//
//  Model.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import Foundation

//MARK: - JSON DATA

struct FetchResults: Codable {
    let resultCount: Int?
    let results: [MovieFetchResult]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount, results
    }
    
}

struct MovieFetchResult: Codable, Identifiable {
    let id = UUID()
    let trackName: String?
    let trackId: Int
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let trackPrice: Float?
    let currency, primaryGenreName, shortDescription, longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case trackName, trackId, artworkUrl30, artworkUrl60, artworkUrl100, trackPrice, primaryGenreName, shortDescription, longDescription, currency
    }
}

struct MovieDetail: Codable, Identifiable {
    var id = UUID()
    let movie: MovieFetchResult
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, movie, isFavorite
    }
}

//MARK: - Mock Data

struct MockMovieData {
    static let sampleMovie = MovieDetail(
        movie: MovieFetchResult(
            trackName: "Hi",
            trackId: 123,
            artworkUrl30: "URL 30",
            artworkUrl60: "URL 60",
            artworkUrl100: "URL 100",
            trackPrice: 12.21, currency: "PHP",
            primaryGenreName: "Action",
            shortDescription: "Shosrgsdfsgcv sdfdf",
            longDescription: "sdfbjhnzf srogjsnfd jgk d ogjsndfgjkn f"),
        isFavorite: false)
    
    
    static let movies = [sampleMovie, sampleMovie]
}

//MARK: - Favorite Movies Manager
// added a manager to handle with the favorite movies list
// this is the only solution that I have found that would overcome the issue with button icon not updating but the list is  correctly updated
class FavoriteMoviesManager: ObservableObject {
    static let shared = FavoriteMoviesManager()
    var favoriteMoviesList: [Int] = []
    
    init() {}
    
    func updateFavoriteList(for movieId: Int) {
        print("#2 Favorite is toggled here")
        if let index = favoriteMoviesList.firstIndex(where: { $0 == movieId}) {
            favoriteMoviesList.remove(at: index)
        } else {
            favoriteMoviesList.append(movieId)
        }
        print(favoriteMoviesList)
    }
    
}
