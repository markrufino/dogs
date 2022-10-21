//
//  DogSubBreedsViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

class DogSubBreedsViewModel {
    
    private let breed: Breed
    
    var onReloadData: (() -> Void)?
    
    init(_ breed: Breed) {
        self.breed = breed
    }
}

extension DogSubBreedsViewModel: ItemsViewModel {
    var items: [ItemCellViewModel] {
        breed.subBreeds.map({ DogSubBreedCellViewModel(subBreedName: $0) })
    }
}
