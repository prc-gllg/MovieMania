//
//  MovieListCell.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import SwiftUI
import URLImage

//MARK: - Movie List Cell View

struct MovieListCell: View {
    let movieCellItem: MovieDetail
    @ObservedObject var movieListCell_VM: MovieListCell_ViewModel
    
    init(movieCellItem: MovieDetail) {
        self.movieCellItem = movieCellItem
        self.movieListCell_VM = MovieListCell_ViewModel(movie: movieCellItem)
    }
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            MovieCellImage(imageURL: movieListCell_VM.imageURL)
                .background(Color(.red))
            VStack(alignment: .leading) {
                Text(movieListCell_VM.titleText)
                    .font(.title2)
                Text(movieListCell_VM.genre)
                    .font(.subheadline)
                Text(movieListCell_VM.price)
                    .font(.caption)
            }
            Spacer()
            Button(action: {
                
                //when the favorite ("star") button is pressed, this function is called
                //the button icon changes and the favorite list is updated accordingly
                
                movieListCell_VM.toggleFavorite()
            }) {
                Image(systemName: movieListCell_VM.isFavorite ? "star.fill" : "star")
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//        .background(Color(.blue))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
//
//struct MovieListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListCell(movieCellItem: MockMovieData.sampleMovie)
//    }
//}

//MARK: - Movie Cell Image
//this view handles the image separately to avoid clutter

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
