//
//  ContentView.swift
//  MovieMania
//
//  Created by Pierce Gallego on 9/15/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject private var favoriteMoviesManager: FavoriteMoviesManager
    @State private var isView: Int = 0
    @State private var navigationTitle: String = "Movie List"
    
    var body: some View {
        NavigationView {
            // to avoid clutter, the initialization of tab items are done in a loop
            let tabItems = Self.tabItems(isView: $isView, favoriteMoviesManager: favoriteMoviesManager)
            TabView(selection: $isView) {
                ForEach(tabItems.indices, id: \.self) { index in
                    let item = tabItems[index]
                    item.view
                        .tabItem {
                            Image(systemName: item.icon)
                            Text(item.title)
                        }
                        .tag(item.id)
                }
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = UIColor(Color(.white).opacity(100))
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
            .tint(Color(.red))
            .navigationTitle(navigationTitle)
            .onChange(of: isView) { newValue in
                navigationTitle = tabItems[newValue].navTitle
            }
            .navigationBarTitleDisplayMode(.automatic)
        }
        .tint(Color.red)
    }
}

//MARK: - TabItems

extension ContentView {
    struct TabItem: Identifiable {
        let id = UUID()
        let title: String
        let navTitle: String
        let icon: String
        let view: AnyView
    }
    // function to handle tab items, any futher additional tabs will be inserted here will be then considered in the loop
    static func tabItems(isView: Binding<Int>, favoriteMoviesManager: FavoriteMoviesManager) -> [TabItem] {
        [TabItem(title: "Movies", navTitle: "Movie List", icon: "house", view: AnyView(MovieList_View(isView: isView, favoriteMoviesManager: favoriteMoviesManager))),
         TabItem(title: "Favorites", navTitle: "Favorite List", icon: "star", view: AnyView(FavoriteMovies_View(isView: isView, favoriteMoviesManager: favoriteMoviesManager)))
        ]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
