//
//  MockURLGenerator.swift
//  JsonPlaceholderTestTests
//
//  Created by joan mazo on 11/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation
@testable import JsonPlaceholderTest

final class MockURLGenerator: URLGenerable {
    var baseUrl: String = "https://jsonplaceholder.typicode.com/"
    
    func getUrl(for endpoint: Endpoint) -> URL? {
        return URL(string: baseUrl)
    }
}
