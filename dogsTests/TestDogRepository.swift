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
        let repository = DogDataRepository(env: .default)
        let expectation = self.expectation(description: "fetchAllBreeds")
        var breeds: [Breed] = []
        
        repository.fetchAllBreeds { result in
            switch result {
            case .success(let _breeds):
                breeds = _breeds
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(!breeds.isEmpty)
        XCTAssertEqual(breeds.count, 98)
        XCTAssertEqual(breeds[5].subBreeds[0], "shepherd")
    }
    
    func test_fetchDogImagesByBreedOnly() {
        let repository = DogDataRepository(env: .default)
        let breed = "hound"
        let expectation = self.expectation(description: "fetchByBreedOnly")
        var images: [DogImage] = []
        
        repository.fetchDogImages(byBreed: breed, subBreed: nil, count: 10, inPage: 1) { result in
            switch result {
            case .success(let _images):
                images = _images;
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(images.count, 10)
    }
    
    func test_fetchDogImagesByBreedOnlyPagination() {
        let repository = DogDataRepository(env: .default)
        let breed = "hound"
        let expectation = self.expectation(description: "fetchDogImagesByBreedOnlyPagination")
        var images: [DogImage] = []
        
        repository.fetchDogImages(byBreed: breed, subBreed: nil, count: 10, inPage: 2) { result in
            switch result {
            case .success(let _images):
                images = _images;
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(images[1].url.absoluteString, "https://images.dog.ceo/breeds/hound-afghan/n02088094_1126.jpg")
    }
    
    func test_fetchDogImagesWithSubBreed() {
        let repository = DogDataRepository(env: .default)
        let breed = "hound"
        let subBreed = "afghan"
        let expectation = self.expectation(description: "fetchDogImagesWithSubBreed")
        var images: [DogImage] = []
        
        repository.fetchDogImages(byBreed: breed, subBreed: subBreed, count: 10, inPage: 1) { result in
            switch result {
            case .success(let _images):
                images = _images;
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(images[2].url.absoluteString, "https://images.dog.ceo/breeds/hound-afghan/n02088094_1023.jpg")
    }
    
    func test_fetchDogImagesWithSubBreedExceedPagination() {
        let repository = DogDataRepository(env: .default)
        let breed = "hound"
        let subBreed = "afghan"
        let expectation = self.expectation(description: "fetchDogImagesWithSubBreedExceedPagination")
        var images: [DogImage] = []
        
        repository.fetchDogImages(byBreed: breed, subBreed: subBreed, count: 10, inPage: 1000) { result in
            switch result {
            case .success(let _images):
                images = _images;
                expectation.fulfill()
            case .failure:
                XCTAssert(false)
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(images.isEmpty)
    }
    
}
