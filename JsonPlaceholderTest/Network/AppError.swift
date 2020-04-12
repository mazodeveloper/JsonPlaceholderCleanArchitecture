//
//  AppError.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

enum AppError: Error, LocalizedError {
    case wrongURL
    case server
    case decode
    case cache(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .wrongURL:
            return NSLocalizedString("There was an error trying to setup the url.", comment: "Wrong URL")
        case .server:
            return NSLocalizedString("There was an error on the server.", comment: "Server error")
        case .decode:
            return NSLocalizedString("Decode error", comment: "There was an error trying to decode the data comes from the server to the app object.")
        case .cache(let error):
            return NSLocalizedString("Something went wrong with the database, error: \(error.localizedDescription)", comment: error.localizedDescription)
        }
    }
}
