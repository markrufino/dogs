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
    
    private var dogImages: [DogImage] = []
    
    private var currentPage = 1
    
    init(
        breedName: String,
        dogRepo: DogRepository = DogDataRepository(env: .default)
    ) {
        self.breedName = breedName
        self.dogRepo = dogRepo
        
        loadNextPage()
    }
}

extension DogPicturesViewModel: PicturesTableViewModel {
    var imageURLs: [URL] {
        dogImages.map({ $0.url })
    }
    
    func loadNextPage() {
        dogRepo.fetchDogImages(
            byBreed: breedName,
            count: 10,
            inPage: currentPage
        ) { [weak self] result in
            guard let dogImages = try? result.get(), let self = self else { return }
            
            self.dogImages.append(contentsOf: dogImages)
            self.onReloadData?()
            self.currentPage += 1
        }
    }
}
