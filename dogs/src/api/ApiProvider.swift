//
//  ApiProvider.swift
//  dogs
//
//  Created by Mark Rufino on 10/20/22.
//

import Foundation
import Moya

class ApiProvider: MoyaProvider<ApiService> {
    
    enum Env {
        case test
        case `default`
    }
    
    init(env: Env) {
        switch env {
        case .test:
            super.init(stubClosure: MoyaProvider.immediatelyStub)
        default:
            super.init()
        }
    }
    
}
