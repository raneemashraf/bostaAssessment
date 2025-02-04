//
//  Photo.swift
//  BostaAlbums
//
//  Created by raneem on 04/02/2025.
//

import Foundation

// MARK: - Photo Model
struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
