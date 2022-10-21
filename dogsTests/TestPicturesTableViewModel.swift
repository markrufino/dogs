//
//  TestPicturesViewModel.swift
//  dogsTests
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

import XCTest
@testable import dogs

class TestPicturesTableViewModel: XCTestCase {
    
    /// It should correctly state if the user has reached the last page.
    func testHasReachedLastPage() {
        let viewModel: PicturesTableViewModel = DogPicturesViewModel(
            breedName: "Hound",
            subBreed: "Afghan",
            dogRepo: DogDataRepository(env: .test)
        )
        
        XCTAssertFalse(viewModel.hasReachedLastPage)
        
        for _ in 0..<100 {
            viewModel.loadNextPage()
        }
        XCTAssertTrue(viewModel.hasReachedLastPage)
    }
    
    /// It should load 10 images initially
    func testImageURLsCount() {
        let viewModel: PicturesTableViewModel = DogPicturesViewModel(
            breedName: "Hound",
            subBreed: "Afghan",
            dogRepo: DogDataRepository(env: .test)
        )
        
        XCTAssertTrue(viewModel.imageURLs.count == 10)
    }
    
    
}
