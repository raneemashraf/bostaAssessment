//
//  ProfileViewControllerProtocol.swift
//  BostaAlbums
//
//  Created by raneem on 28/02/2025.
//

protocol ProfileViewControllerProtocol: AnyObject {
    func setupUI()
    func bindViewModel()
    func updateUserName(_ name: String)
    func updateAddress(_ address: String)
    func reloadAlbums()
}
