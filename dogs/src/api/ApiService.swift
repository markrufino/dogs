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
    case getImagesByBreed(breed: String, subBreed: String?)
    
}

extension ApiService: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://dog.ceo/api")!
    }
    
    var path: String {
        switch self {
        case .getAllBreeds:
            return "/breeds/list/all"
        case .getImagesByBreed(let breed, let subBreed):
            if let _subBreed = subBreed {
                return "/breed/\(breed)/\(_subBreed)/images"
            }
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
    
    var sampleData: Data {
        switch self {
        case .getAllBreeds:
            return loadStubData("stubGetAllBreeds")
        case .getImagesByBreed:
            return loadStubData("stubGetImagesByBreed")
        }
    }
    
    var headers: [String : String]? {
        return ["content-type": "json"]
    }
    
    
}

extension ApiService {
    
    private func loadStubData(_ fileName: String) -> Data {
        guard
            let res = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: res)
        else {
            return "{}".data(using: .utf8)!
        }
        return data
    }
}
