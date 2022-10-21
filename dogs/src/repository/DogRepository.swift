//
//  BreedsRepository.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation
import Alamofire

typealias FetchAllBreedsHandler = (Result<[Breed], Error>) -> Void
typealias FetchDogImagesHandler = (Result<[DogImage], Error>) -> Void

protocol DogRepository {
    func fetchAllBreeds(handler: @escaping FetchAllBreedsHandler)

    func fetchDogImages(byBreed breed: String, subBreed: String?, count: Int, inPage pge: Int, handler: @escaping FetchDogImagesHandler)
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
    
    
    /// NOTE: Page starts at 1
    func fetchDogImages(byBreed breed: String, subBreed: String?, count: Int, inPage page: Int, handler: @escaping FetchDogImagesHandler) {
        provider.request(.getImagesByBreed(breed: breed, subBreed: subBreed)) { result in
            switch result {
            case .success(let resp):
                
                do {
                    let mapped = try JSONDecoder().decode(GetImagesByBreedResponse.self, from: resp.data)
                    
                    let chunks = mapped.message
                        .map({ DogImage(url: $0) })
                        .chunked(into: count)
                    
                    guard (chunks.count > page - 1) else {
                        handler(.success([]))
                        return
                    }
                    
                    let paginated = chunks[page - 1]
                    
                    handler(.success(paginated))
                } catch {
                    handler(.failure(error))
                }
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
}
