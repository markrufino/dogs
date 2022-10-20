//
//  BreedsRepository.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation
import Alamofire

typealias Breed = String
typealias FetchAllBreedsHandler = (Result<[String], Error>) -> Void
typealias FetchDogsHandler = (Result<[String], Error>) -> Void

protocol DogRepository {
    func fetchAllBreeds(handler: FetchAllBreedsHandler)
    func fetchDogImages(byBreed breed: Breed, inPage pge: Int, handler: FetchDogsHandler)
}

class DogDataRepository: DogRepository {
    
    let provider = ApiProvider()
    
    func fetchAllBreeds(handler: FetchAllBreedsHandler) {
    }
    
    func fetchDogImages(byBreed breed: Breed, inPage page: Int, handler: FetchDogsHandler) {
    }
    
}
