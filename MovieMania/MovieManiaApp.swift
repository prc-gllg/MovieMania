//
//  MovieManiaApp.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import SwiftUI

@main
struct MovieManiaApp: App {
    //singleton favorite list manager -- ensures that there is only one list of favorites
    let favoriteMoviesManager = FavoriteMoviesManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoriteMoviesManager)
        }
    }
}
