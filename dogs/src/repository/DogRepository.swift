//
//  BreedsRepository.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation
import Alamofire

typealias FetchAllBreedsHandler = (Result<[Breed], Error>) -> Void
typealias FetchDogsHandler = (Result<[String], Error>) -> Void

protocol DogRepository {
    func fetchAllBreeds(handler: @escaping FetchAllBreedsHandler)
    func fetchDogImages(byBreed breed: String, inPage pge: Int, handler: @escaping FetchDogsHandler)
}

class DogDataRepository: DogRepository {
    
    func fetchAllBreeds(handler: @escaping FetchAllBreedsHandler) {
        ApiProvider.default.request(.getAllBreeds) { result in
            switch result {
            case .success(let resp):
                
                do {
                    let allBreeds = try JSONDecoder().decode(GetAllBreedsResponse.self, from: resp.data)
                    handler(.success([]))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func fetchDogImages(byBreed breed: String, inPage page: Int, handler: @escaping FetchDogsHandler) {
    }
    
}
