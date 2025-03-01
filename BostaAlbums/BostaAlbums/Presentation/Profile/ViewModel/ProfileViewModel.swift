//
//  ProfileViewModel.swift
//  BostaAlbums
//
//  Created by raneem on 04/02/2025.
//

import Foundation
import Combine
import Moya

class ProfileViewModel {
    private let provider = MoyaProvider<APIService>()
    @Published var user: User?
    @Published var albums: [Album] = []
    
    private weak var view: ProfileViewControllerProtocol?
    
    init(view: ProfileViewControllerProtocol?) {
        self.view = view
    }
    
    func fetchUser() {
        provider.request(.getUsers) { [weak self] result in
            switch result {
            case .success(let response):
                let users = try? JSONDecoder().decode([User].self, from: response.data)
                self?.user = users?.randomElement()
                if let userId = self?.user?.id {
                    self?.fetchAlbums(userId: userId)
                }
            case .failure(let error):
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }

    func fetchAlbums(userId: Int) {
        provider.request(.getAlbums(userId: userId)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.albums = (try? JSONDecoder().decode([Album].self, from: response.data)) ?? []
            case .failure(let error):
                print("Error fetching albums: \(error.localizedDescription)")
            }
        }
    }
}
