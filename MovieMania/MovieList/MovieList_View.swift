//
//  ContentView2.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import SwiftUI

//MARK: - Movie List View

struct MovieList_View: View {
    
    //isView is wrapped with @Binding with the intention of passing data from this view to the ContentView -- this variable is being used to identify which view is being shown when a tab item is tapped
    //movieList_VM is wrapped with @StateObject to ensure that the view model persists as long as this view persists as well
    //favoriteMoviesManager is wrapped with @EnvironmentObject; an injection of the singleton from the MovieManiaApp file to allow access of the manager in this file
    
    @Binding var isView: Int
    @StateObject private var movieList_VM: MovieList_ViewModel
    @EnvironmentObject var favoriteMoviesManager: FavoriteMoviesManager
    
    init(isView: Binding<Int>, favoriteMoviesManager: FavoriteMoviesManager) {
        self._isView = isView
        self._movieList_VM = StateObject(wrappedValue: MovieList_ViewModel(favoriteMoviesManager: favoriteMoviesManager))
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(movieList_VM.movieList) { movie in
                    NavigationLink(destination:
                        MovieDetail_View(movie: movie)
                    ){
                        MovieListCell(movieCellItem: movie)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear {
            movieList_VM.fetchMovies()
        }
    }
}
