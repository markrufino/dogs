//
//  GetAllBreedsResponse.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation

struct GetAllBreedsResponse: Decodable {
    var message: [String: [String]]
    var status: String?
}
