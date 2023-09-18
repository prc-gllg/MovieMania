//
//  MovieDetail_View.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/18/23.
//

import SwiftUI
import URLImage

//MARK: - Movie Detail View

//this view handles additional information

struct MovieDetail_View: View {
    let movieDetailItem: MovieDetail
    @ObservedObject private var movieDetail_VM: MovieDetail_ViewModel
    init(movie: MovieDetail) {
        self.movieDetailItem = movie
        movieDetail_VM = MovieDetail_ViewModel(movie: movie)
    }
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 10){
                GeometryReader { geometry in
                    MediaDetailImage(imageURL: movieDetail_VM.imageURL, size: CGSize(width: geometry.size.width, height: 200))
                        .cornerRadius(10)
                }
                .frame(height: 200)
                HStack {
                    Text(movieDetail_VM.title)
                        .font(.title)
                    Spacer()
                    Button(action: {
                        //i need the toggle function here
                        movieDetail_VM.toggleFavorite()
                    }) {
                        Image(systemName: movieDetail_VM.isFavorite ? "star.fill" : "star")
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 20))
                    }
                }
                .frame(maxWidth: .infinity)
                Text(movieDetail_VM.genre)
                    .font(.caption)
                Text(movieDetail_VM.plot)
            }
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail_View(movie: MockMovieData.sampleMovie)
    }
}

//MARK: - Movie Detail Image
//this view handles the image separately to avoid clutter

struct MediaDetailImage: View {
    let imageURL: URL?
    let size: CGSize
    var body: some View {
        if let imageURL = imageURL {
            URLImage(imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: size.width, maxHeight: size.height)
                    .clipped()
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: size.width, maxHeight: size.height)
        }
    }
}

