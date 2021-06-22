//
//  SpotifyHomeScreen.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 09/06/21.
//

import SwiftUI

struct SpotifyHomeScreen: View {
    @StateObject var viewModel = SpotifyHomeScreenModel()
    @State var searchText: String = ""
    let threeColumns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    let shimmerData = (1...6).map { "Item \($0)" }
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVStack(alignment: .leading, spacing: 10) {
                    searchView
                    newReleasesView
                    featuredPlaylistView
                    categoriesView
                }
                .padding(10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .background(Color.darkBlue.edgesIgnoringSafeArea(.all))
            .navigationBarTitle(Text("Find Your Best Music"))
        }
    }
    
    var searchView: some View {
        return HStack(spacing: 10){
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $searchText)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.darkBlueControl)
        .cornerRadius(8)
    }
    
    var newReleasesView: some View {
        VStack(spacing: 10) {
            SeeMoreWithTitleView(title: "New Releases") {
                
            }
            newReleasesContentView
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.darkBlueControl)
        .cornerRadius(8)
    }
    
    private var newReleasesContentView: some View {
        switch viewModel.newReleaseState {
        case .loading:
            return LazyVGrid(columns: threeColumns, spacing: 2) {
                ForEach(shimmerData, id: \.self) { item in
                    ShimmerView().cornerRadius(6)
                }
            }.cornerRadius(6).eraseToAnyView()
        case .loaded(let items):
            return LazyVGrid(columns: threeColumns, spacing: 2) {
                ForEach(items) { item in
                    ZStack(alignment: .bottom) {
                        URLImage(urlString: item.images[0].url, placeholder: nil).scaledToFit()
                    }
                }
            }.cornerRadius(6).eraseToAnyView()
        case .error(let error):
            return Text(error).foregroundColor(.red).eraseToAnyView()
        }
    }
    
    var featuredPlaylistView: some View {
        VStack(spacing: 10) {
            SeeMoreWithTitleView(title: "Featured Playlists") {
                
            }
            featuredPlaylistContentView
        }.padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.darkBlueControl)
        .cornerRadius(8)
    }
    
    private var featuredPlaylistContentView: some View {
        switch viewModel.featuredPlaylistState {
        case .loading:
            return  LazyVGrid(columns: threeColumns, spacing: 2) {
                ForEach(shimmerData, id: \.self) { item in
                    ShimmerView().cornerRadius(6)
                }
            }.cornerRadius(6).eraseToAnyView()
        case .loaded(let items):
            return LazyVGrid(columns: threeColumns, spacing: 2) {
                ForEach(items) { item in
                    ZStack(alignment: .bottom) {
                        URLImage(urlString: item.images[0].url, placeholder: nil).scaledToFit()
                    }
                }
            }.cornerRadius(6).eraseToAnyView()
        case .error(let error):
            return Text(error).foregroundColor(.red).eraseToAnyView()
        }
    }
    
    private var categoriesView: some View {
        VStack(spacing: 10) {
            SeeMoreWithTitleView(title: "Categories") {
                
            }
            categoriesContentView
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.darkBlueControl)
        .cornerRadius(8)
    }
    
    private var categoriesContentView: some View {
        switch viewModel.categoriesState {
        case .loading:
            return  LazyVGrid(columns: threeColumns, spacing: 2) {
                ForEach(shimmerData, id: \.self) { item in
                    ShimmerView().aspectRatio(1, contentMode: .fill) .cornerRadius(6)
                }
            }.cornerRadius(6).eraseToAnyView()
        case .loaded(let items):
            return LazyVGrid(columns: threeColumns, spacing: 2) {
                ForEach(items) { item in
                    ZStack(alignment: .bottom) {
                        URLImage(urlString: item.icons[0].url, placeholder: nil).scaledToFit()
                        Text(item.name).font(.subheadline).padding(4)
                        
                    }
                }
            }.cornerRadius(6).eraseToAnyView()
        case .error(let error):
            return Text(error).foregroundColor(.red).eraseToAnyView()
        }
    }
    
}

struct SpotifyHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyHomeScreen()
    }
}

struct SeeMoreWithTitleView: View {
    var title: String
    var seeMore: () -> Void
    var body: some View {
        HStack {
            Text(title).font(.headline)
            Spacer()
            Button("See More", action: seeMore)
        }
    }
}
