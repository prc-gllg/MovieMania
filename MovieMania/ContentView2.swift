//
//  ContentView2.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import SwiftUI

struct ContentView2: View {
    @StateObject private var viewModel = MovieList_ViewModel()
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.movieList) { movie in
                    MovieListCell(movieCellItem: movie, movieList_VM: viewModel)
                    
                }
            }
        }
        .onAppear {
            viewModel.fetchMovies()
        }
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
