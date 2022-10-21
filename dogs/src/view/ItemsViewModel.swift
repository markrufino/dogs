//
//  DogsViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

protocol ItemsViewModel: AnyObject {
    
    var items: [ItemCellViewModel] { get }
    
    var onReloadData: (() -> Void)? { get set }
    
}
