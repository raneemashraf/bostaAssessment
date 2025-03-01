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
    @Published var filteredPhotos: [Photo] = []
    
    private weak var view: AlbumsDetailsViewProtocol?
    
    init(view: AlbumsDetailsViewProtocol?) {
        self.view = view
    }
    
    func fetchPhotos(albumId: Int) {
        provider.request(.getPhotos(albumId: albumId)) { [weak self] result in
            switch result {
            case .success(let response):
                if let photos = try? JSONDecoder().decode([Photo].self, from: response.data) {
                    self?.filteredPhotos = photos
                    self?.view?.reloadCollectionView()
                }
            case .failure(let error):
                self?.view?.showError("Failed to load photos: \(error.localizedDescription)")
            }
        }
    }
    
    func searchPhotos(query: String) {
        if query.isEmpty {
            return
        }
        
        filteredPhotos = filteredPhotos.filter { $0.title.lowercased().contains(query.lowercased()) }
        view?.reloadCollectionView()
    }
    
    func setAlbumName(_ name: String) {
        view?.updateAlbumName(name)
    }
}

