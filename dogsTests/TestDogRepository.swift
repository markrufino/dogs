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
            case .failure(let error):
                XCTAssert(false)
            }
        }
        
    }
    
    func testFetchDogImagesByBreed() {
        
    }
    
}
