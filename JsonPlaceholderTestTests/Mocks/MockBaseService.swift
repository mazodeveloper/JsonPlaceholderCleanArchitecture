//
//  MockBaseService.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
@testable import JsonPlaceholderTest

final class MockBaseService: BaseService {
    let result: ServiceResponse<Data>
    
    init(result: ServiceResponse<Data>) {
        self.result = result
    }
    
    func callEndpoint<Model>(responseType: Model.Type, url: URL?, completion: @escaping (ServiceResponse<Model>) -> Void) where Model : Codable {
        switch result {
        case .failure(let error):
            completion(.failure(error: error))
        case .success(let data):
            do {
                let dataModel = try JSONDecoder().decode(responseType, from: data)
                completion(.success(response: dataModel))
            } catch {
                completion(.failure(error: error))
            }
        }
    }
}
