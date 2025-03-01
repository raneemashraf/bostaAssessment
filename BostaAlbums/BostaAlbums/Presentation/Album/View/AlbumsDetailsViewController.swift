//
//  AlbumsDetailsViewController.swift
//  BostaAlbums
//
//  Created by raneem on 01/03/2025.
//

import UIKit
import Combine
import SDWebImage

class AlbumsDetailsViewController: UIViewController, AlbumsDetailsViewProtocol {
    
    @IBOutlet private weak var albumName: UILabel!
    @IBOutlet private weak var albumsSearchBar: UISearchBar!
    @IBOutlet private weak var albumsCollectionView: UICollectionView!
    
    private var albumViewModel: AlbumViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    var album: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumViewModel = AlbumViewModel(view: self)
        
        setupCollectionView()
        
        setupUI()
        
        if let albumId = album?.id {
            albumViewModel.fetchPhotos(albumId: albumId)
            albumViewModel.setAlbumName(album?.title ?? "")
        }
    }
    
    func setupUI() {
        albumsSearchBar.delegate = self
        albumsCollectionView.dataSource = self
        albumsCollectionView.delegate = self
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        albumsCollectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "AlbumsDetailsCollectionViewCell", bundle: nil)
        albumsCollectionView.register(nib, forCellWithReuseIdentifier: "albumsCell")
    }
    
    // MARK: - AlbumsDetailsView Protocol Methods
    
    func updateAlbumName(_ name: String) {
        albumName.text = name
    }
    
    func reloadCollectionView() {
        albumsCollectionView.reloadData()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension AlbumsDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        albumViewModel.searchPhotos(query: searchText)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension AlbumsDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumViewModel.filteredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumsCell", for: indexPath) as! AlbumsDetailsCollectionViewCell
        let photo = albumViewModel.filteredPhotos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
}


