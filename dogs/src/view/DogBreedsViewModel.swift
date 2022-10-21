//
//  DogBreedsViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

class DogBreedsViewModel {
    
}

// MARK: - ItemsViewModel

extension DogBreedsViewModel: ItemsViewModel {
    var items: [ItemCellViewModel] {
        [
            DogBreedCellViewModel(),
            DogBreedCellViewModel(),
            DogBreedCellViewModel()
        ]
    }
}
