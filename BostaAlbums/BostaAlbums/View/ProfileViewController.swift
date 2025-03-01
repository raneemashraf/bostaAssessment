//
//  ViewController.swift
//  BostaAlbums
//
//  Created by raneem on 04/02/2025.
//

import UIKit
import Combine

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    @IBOutlet private weak var userName: UILabel!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var albumsTableView: UITableView!
    
    private var viewModel = ProfileViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchUser()
    }
    
    func setupUI() {
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
    }
    
    func bindViewModel() {
        viewModel.$albums.receive(on: DispatchQueue.main).sink { [weak self] _ in
            self?.albumsTableView.reloadData()
        }.store(in: &cancellables)
        
        viewModel.$user.receive(on: DispatchQueue.main).sink { [weak self] user in
            guard let user = user else { return }
            self?.userName.text = user.name
            self?.address.text = user.address.street
        }.store(in: &cancellables)
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let album = viewModel.albums[indexPath.row]
        cell.textLabel?.text = album.title
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let album = viewModel.albums[indexPath.row]
    //        let albumVC = AlbumViewController(albumId: album.id)
    //        navigationController?.pushViewController(albumVC, animated: true)
    //    }
}


