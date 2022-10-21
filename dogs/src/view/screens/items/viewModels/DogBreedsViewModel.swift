//
//  DogBreedsViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

class DogBreedsViewModel {
    
    let dogRepo: DogRepository
    
    var onReloadData: (() -> Void)?
    
    private(set) var breeds: [Breed] = []
    
    init(_ dogRepo: DogRepository = DogDataRepository(env: .default)) {
        self.dogRepo = dogRepo
        setup()
    }
    
    private func setup() {
        loadData()
    }
    
    private func loadData() {
        dogRepo.fetchAllBreeds { [weak self] result in
            if let breeds = try? result.get() {
                self?.breeds = breeds
                self?.onReloadData?()
            }
        }
    }
    
}

// MARK: - ItemsViewModel

extension DogBreedsViewModel: ItemsViewModel {
    var items: [ItemCellViewModel] {
        breeds.map({ DogBreedCellViewModel($0) })
    }
}
