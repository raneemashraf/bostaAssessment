//
//  AlbumsDetailsView.swift
//  BostaAlbums
//
//  Created by raneem on 01/03/2025.
//

protocol AlbumsDetailsViewProtocol: AnyObject {
    func updateAlbumName(_ name: String)
    func reloadCollectionView()
    func showError(_ message: String)
}
