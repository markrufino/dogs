//
//  DogSubBreedCellViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

class DogSubBreedCellViewModel {
    
    private let subBreedName: String
    
    init(subBreedName: String) {
        self.subBreedName = subBreedName
    }
    
}

// MARK: - ItemCellViewModel

extension DogSubBreedCellViewModel: ItemCellViewModel {
    var title: String {
        subBreedName.capitalized
    }
    
    var subtitle: String? {
        nil
    }
}
