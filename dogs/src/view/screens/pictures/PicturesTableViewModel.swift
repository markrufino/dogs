//
//  PicturesTableViewModel.swift
//  dogs
//
//  Created by Mac Romel D. Noble on 10/21/22.
//

import Foundation

protocol PicturesTableViewModel: AnyObject {
    var imageURLs: [URL] { get }
    var onReloadData: (() -> Void)? { get set }
}
