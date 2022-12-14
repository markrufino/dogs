//
//  MainCoordinator.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import UIKit

class MainCoordinator {
    
    private let nav: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.nav = navigationController
    }
    
    func start() {
        let vm = DogBreedsViewModel()
        let mainVC = ItemsViewController(vm, vm)
        mainVC.title = "Breeds"
        mainVC.didSelectItemAt = { indexPath in
            let breed = vm.breeds[indexPath.row]
            if breed.subBreeds.isEmpty {
                // If there's no subreed, just show the dog images instead.
                self.showPicturesFor(breedName: breed.main, subBreed: nil)
            } else {
                self.showSubBreedsViewFor(vm.breeds[indexPath.row])
            }
        }
        nav.pushViewController(mainVC, animated: false)
    }
    
    func showSubBreedsViewFor(_ breed: Breed) {
        let vm = DogSubBreedsViewModel(breed)
        let itemsVC = ItemsViewController(vm)
        itemsVC.title = "\(breed.main.capitalized) subbreeds"
        itemsVC.didSelectItemAt = { indexPath in
            let subBreedName = breed.subBreeds[indexPath.row]
            self.showPicturesFor(breedName: breed.main, subBreed: subBreedName)
        }
        
        nav.pushViewController(itemsVC, animated: true)
    }
    
    func showPicturesFor(breedName: String, subBreed: String?) {
        let vm = DogPicturesViewModel(breedName: breedName, subBreed: subBreed)
        let pictureTableVC = PicturesTableViewController(vm)
        pictureTableVC.title = breedName.capitalized
        
        nav.pushViewController(pictureTableVC, animated: true)
    }
    
}
