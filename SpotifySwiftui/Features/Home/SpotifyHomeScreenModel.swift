//
//  SpotifyHomeScreenModel.swift
//  RecipeSwiftui2pointO
//
//  Created by Gaurang Vyas on 10/06/21.
//

import Combine
import Foundation

class SpotifyHomeScreenModel: ObservableObject {
    @Published private(set) var categoriesState: State<[SpotifyCategoriesModel.Item]>
    @Published private(set) var newReleaseState: State<[SpotifyNewReleaseModel.Item]>
    @Published private(set) var featuredPlaylistState: State<[SpotifyFeaturedPlaylist.Item]>
    private var bag = Set<AnyCancellable>()
    @Published var categories: [SpotifyCategoriesModel.Item] = []
    @Published var newReleases: [SpotifyNewReleaseModel.Item] = []

    var totalHits: Int = 0
    
    init() {
        categoriesState = .loading
        newReleaseState = .loading
        featuredPlaylistState = .loading
        newReleasesRequest()
        categoriesRequest()
        featuredPlaylistRequest()
    }

}

extension SpotifyHomeScreenModel {
    enum State<T> {
        case loading
        case loaded(T)
        case error(String)
    }

}

extension SpotifyHomeScreenModel {
    
    private func newReleasesRequest() {
        let onErrorCompletion: ((Subscribers.Completion<Error>) -> Void) = { completion in
            switch completion {
            case .finished: print(#function,"🏁 finished")
            case .failure(let error):
                self.newReleaseState = .error(error.localizedDescription)
            }
        }
        let onValue: (SpotifyNewReleaseModel) -> Void = { value in
            if let error = value.error {
                self.newReleaseState = .error(error.message)
            } else if let items = value.albums?.items {
                self.newReleaseState = .loaded(items)
            } else {
                self.newReleaseState = .error("Something went wrong")
            }
        }
        SpotifyAPI
            .fetchNewReleases(offset: 0, limit: 6)
            .sink(receiveCompletion: onErrorCompletion, receiveValue: onValue)
            .store(in: &bag)
    }
    
    private func categoriesRequest() {
        let onErrorCompletion: ((Subscribers.Completion<Error>) -> Void) = { completion in
            switch completion {
            case .finished: print(#function,"🏁 finished")
            case .failure(let error):
                self.categoriesState = .error(error.localizedDescription)
            }
        }
        let onValue: (SpotifyCategoriesModel) -> Void = { value in
            if let error = value.error {
                self.categoriesState = .error(error.message)
            } else if let items = value.categories?.items {
                self.categoriesState = .loaded(items)
            } else {
                self.categoriesState = .error("Something went wrong")
            }
        }
        SpotifyAPI
            .fetchCategories()
            .sink(receiveCompletion: onErrorCompletion, receiveValue: onValue)
            .store(in: &bag)
    }
    
    private func featuredPlaylistRequest() {
        let onErrorCompletion: ((Subscribers.Completion<Error>) -> Void) = { completion in
            switch completion {
            case .finished: print(#function,"🏁 finished")
            case .failure(let error):
                self.categoriesState = .error(error.localizedDescription)
            }
        }
        let onValue: (SpotifyFeaturedPlaylist) -> Void = { value in
            if let error = value.error {
                self.featuredPlaylistState = .error(error.message)
            } else if let items = value.playlists?.items {
                self.featuredPlaylistState = .loaded(items)
            } else {
                self.featuredPlaylistState = .error("Something went wrong")
            }
        }
        SpotifyAPI
            .fetchFeaturedPlaylist(offset: 0, limit: 6)
            .sink(receiveCompletion: onErrorCompletion, receiveValue: onValue)
            .store(in: &bag)
    }
}
