//
//  ApiProvider.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation
import Moya

class ApiProvider {
    
    static let `default` = MoyaProvider<ApiService>()
    
    static let stubbed = MoyaProvider<ApiService>(stubClosure: MoyaProvider.immediatelyStub)
    
}
