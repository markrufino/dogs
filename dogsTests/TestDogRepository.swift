//
//  TestDogRepository.swift
//  dogsTests
//
//  Created by Mark Rufino on 10/20/22.
//

import XCTest
@testable import dogs

class TestDogRepository: XCTestCase {
    
    func testFetchAllBreeds() {
        let repository = DogDataRepository(env: .test)
        
        repository.fetchAllBreeds { result in
            switch result {
            case .success(let breeds):
                XCTAssert(!breeds.isEmpty)
                XCTAssertEqual(breeds.count, 98)
                XCTAssertEqual(breeds[5].subBreeds[0], "shepherd")
            case .failure:
                XCTAssert(false)
            }
        }
        
    }
    
    func testFetchDogImagesByBreed() {
        let repository = DogDataRepository(env: .test)
        let breed = "hound-afghan"
        repository.fetchDogImages(byBreed: breed, count: 10, inPage: 2) { result in
            switch result {
            case .success(let images):
                XCTAssert(!images.isEmpty)
                XCTAssertEqual(images[1].url.absoluteString, "https://images.dog.ceo/breeds/hound-afghan/n02088094_1126.jpg")
            case .failure:
                XCTAssert(false)
            }
        }
        
        repository.fetchDogImages(byBreed: breed, count: 3, inPage: 2) { result in
            switch result {
            case .success(let images):
                XCTAssert(!images.isEmpty)
                XCTAssertEqual(images[1].url.absoluteString, "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg")
            case .failure:
                XCTAssert(false)
            }
        }
    }
    
}
