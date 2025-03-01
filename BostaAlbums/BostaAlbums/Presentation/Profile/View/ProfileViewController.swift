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
    
    private var viewModel: ProfileViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ProfileViewModel(view: self)
        
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
            let addressText = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
            self?.address.text = addressText
        }.store(in: &cancellables)
    }
    
    // MARK: - ProfileViewControllerProtocol methods
    
    func updateUserName(_ name: String) {
        userName.text = name
    }
    
    func updateAddress(_ address: String) {
        self.address.text = address
    }
    
    func reloadAlbums() {
        albumsTableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        performSegue(withIdentifier: "showAlbumsDetails", sender: album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbumsDetails" {
            if let destinationVC = segue.destination as? AlbumsDetailsViewController,
               let selectedAlbum = sender as? Album {
                destinationVC.album = selectedAlbum
            }
        }
    }
}
