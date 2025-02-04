//
//  Album.swift
//  BostaAlbums
//
//  Created by raneem on 04/02/2025.
//


import Foundation

// MARK: - Album Model
struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String
}