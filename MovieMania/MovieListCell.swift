//
//  MovieListCell.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import SwiftUI
import URLImage

struct MovieListCell: View {
    let movieCellItem: MovieDetail
    @ObservedObject var movieListCell_VM: MovieListCell_ViewModel
    @ObservedObject var movieList_VM: MovieList_ViewModel
    
    init(movieCellItem: MovieDetail, movieList_VM: MovieList_ViewModel) {
        self.movieCellItem = movieCellItem
        self.movieList_VM = movieList_VM
        self.movieListCell_VM = MovieListCell_ViewModel(movie: movieCellItem, movieList_VM: movieList_VM)
    }
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            MovieCellImage(imageURL: movieListCell_VM.imageURL)
                .background(Color(.red))
            VStack(alignment: .leading) {
                Text(movieListCell_VM.titleText)
                Text(movieListCell_VM.genre)
                Text(movieListCell_VM.price)
            }
            Spacer()
            Button(action: {
                //i need the toggle function here
                movieListCell_VM.isFavorite.toggle()
//                movieListCell_VM.toggleFavorite()
            }) {
                Image(systemName: movieListCell_VM.isFavorite ? "star.fill" : "star")
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color(.blue))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct MovieListCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieListCell(movieCellItem: MockMovieData.sampleMovie, movieList_VM: MovieList_ViewModel())
    }
}

struct MovieCellImage: View {
    let imageURL: URL?
    var body: some View {
        if let imageURL = imageURL {
            URLImage(imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 150)
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .frame(maxWidth: 50, maxHeight: 50)
        }
    }
}
