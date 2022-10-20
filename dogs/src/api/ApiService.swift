//
//  ApiService.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation
import Moya

enum ApiService {
    
    case getAllBreeds
    case getImagesByBreed(breed: String)
    
}

extension ApiService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://dog.ceo/api")!
    }
    
    var path: String {
        switch self {
        case .getAllBreeds:
            return "/breeds/list/all"
        case .getImagesByBreed(let breed):
            return "/breed/\(breed)/images"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllBreeds, .getImagesByBreed:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getAllBreeds, .getImagesByBreed:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["content-type": "json"]
    }
    
    
}
