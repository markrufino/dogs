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
        let repository = DogDataRepository(env: .default)
        let breed = "hound"
        let expectation = self.expectation(description: "fetchByBreed")
        var images: [DogImage] = []
        
        repository.fetchDogImages(byBreed: breed, subBreed: "afghan", count: 3, inPage: 2) { result in
            switch result {
            case .success(let _images):
                images = _images;
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(!images.isEmpty)
        XCTAssertEqual(images[1].url.absoluteString, "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg")
    }
    
    func testFetchDogImagesWithSubBreed() {
        let repository = DogDataRepository(env: .default)
        let breed = "australian"
        let subBreed = "shepherd"
        let expectation = self.expectation(description: "fetch")
        var images: [DogImage] = []
        
        // Test exceeding page
        repository.fetchDogImages(byBreed: breed, subBreed: subBreed, count: 10, inPage: 1000) { result in
            switch result {
            case .success(let _images):
                images = _images;
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssert(images.isEmpty)
    }
    
}
