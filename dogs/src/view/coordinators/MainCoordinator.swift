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
        let mainVC = ItemsViewController(vm)
        mainVC.title = "Breeds"
        mainVC.didSelectItemAt = { indexPath in
            self.showSubBreedsViewFor(vm.breeds[indexPath.row])
        }
        nav.pushViewController(mainVC, animated: false)
    }
    
    func showSubBreedsViewFor(_ breed: Breed) {
        let vm = DogSubBreedsViewModel(breed)
        let itemsVC = ItemsViewController(vm)
        itemsVC.title = "\(breed.main.capitalized) subbreeds"
        
        nav.pushViewController(itemsVC, animated: true)
    }
    
}
