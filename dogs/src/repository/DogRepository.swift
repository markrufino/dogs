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
    
    let provider: ApiProvider
    
    init(env: ApiProvider.Env) {
        self.provider = ApiProvider(env: env)
    }
    
    func fetchAllBreeds(handler: @escaping FetchAllBreedsHandler) {
        provider.request(.getAllBreeds) { result in
            switch result {
            case .success(let resp):
                
                do {
                    let mapped = try JSONDecoder().decode(GetAllBreedsResponse.self, from: resp.data)
                    let breeds = mapped.message
                        .map { (key, value) in
                            return Breed(main: key, subBreeds: value)
                        }
                        .sorted(by: { $0.main < $1.main })
                    handler(.success(breeds))
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
