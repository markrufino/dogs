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
        let repository = DogDataRepository()
        repository.fetchAllBreeds { result in
            switch result {
            case .success(let success):
                XCTAssert(true)
            case .failure(let error):
                XCTAssert(false)
            }
        }
    }
    
    func testFetchDogImagesByBreed() {
        
    }
    
}
