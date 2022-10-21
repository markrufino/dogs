//
//  DogPictureViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

class DogPicturesViewModel {
    
    var onReloadData: (() -> Void)?
    
    private let dogRepo: DogRepository
    
    private let breedName: String
    
    private let subBreed: String?
    
    private var dogImages: [DogImage] = []
    
    init(
        breedName: String,
        subBreed: String? = nil,
        dogRepo: DogRepository = DogDataRepository(env: .default)
    ) {
        self.breedName = breedName
        self.subBreed = subBreed
        self.dogRepo = dogRepo
        
        loadData()
    }
    
    private func loadData() {
        dogRepo.fetchDogImages(
            byBreed: breedName,
            subBreed: subBreed,
            count: 10,
            inPage: 1
        ) { [weak self] result in
            if let dogImages = try? result.get() {
                self?.dogImages = dogImages
                self?.onReloadData?()
            }
        }
    }
    
}

extension DogPicturesViewModel: PicturesTableViewModel {
    var imageURLs: [URL] {
        dogImages.map({ $0.url })
    }
}
