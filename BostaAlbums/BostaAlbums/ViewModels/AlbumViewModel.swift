//
//  AlbumViewModel.swift
//  BostaAlbums
//
//  Created by raneem on 04/02/2025.
//

import Combine
import Moya
import Foundation

class AlbumViewModel {
    private let provider = MoyaProvider<APIService>()
    @Published var photos: [Photo] = []
    @Published var filteredPhotos: [Photo] = []

    func fetchPhotos(albumId: Int) {
        provider.request(.getPhotos(albumId: albumId)) { result in
            switch result {
            case .success(let response):
                self.photos = (try? JSONDecoder().decode([Photo].self, from: response.data)) ?? []
                self.filteredPhotos = self.photos
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)")
            }
        }
    }

    func searchPhotos(query: String) {
        if query.isEmpty {
            filteredPhotos = photos
        } else {
            filteredPhotos = photos.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
    }
}
