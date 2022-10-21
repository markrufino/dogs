//
//  DogBreedCellViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

class DogBreedCellViewModel {
    
    private let breed: Breed
    
    init(_ breed: Breed) {
        self.breed = breed
    }
    
}

// MARK: - ItemCellViewModel

extension DogBreedCellViewModel: ItemCellViewModel {
    var title: String {
        breed.main.capitalized
    }
    
    var subtitle: String? {
        guard !breed.subBreeds.isEmpty else { return nil }
        
        var subtitle = "\(breed.subBreeds.count) sub breed"
        if breed.subBreeds.count > 1 {
            subtitle.append("s")
        }
        
        return subtitle
    }
    
}
