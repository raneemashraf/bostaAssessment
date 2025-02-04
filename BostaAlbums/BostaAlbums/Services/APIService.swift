//
//  APIService.swift
//  BostaAlbums
//
//  Created by raneem on 04/02/2025.
//

import Moya
import Foundation

enum APIService {
    case getUsers
    case getAlbums(userId: Int)
    case getPhotos(albumId: Int)
}

extension APIService: TargetType {
    var baseURL: URL { return URL(string: "https://jsonplaceholder.typicode.com")! }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getAlbums(let userId):
            return "/albums"
        case .getPhotos(let albumId):
            return "/photos"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task { return .requestPlain }
    var headers: [String: String]? { return nil }
}
