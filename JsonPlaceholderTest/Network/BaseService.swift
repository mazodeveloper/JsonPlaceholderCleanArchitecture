//
//  BaseService.swift
//  JsonPlaceholderTest
//
//  Created by joan mazo on 9/04/20.
//  Copyright © 2020 Joan Mazo. All rights reserved.
//

import Foundation

enum ServiceResponse<Model> {
    case success(response: Model)
    case failure(error: Error)
}

protocol BaseService {
    func callEndpoint<Model: Codable>(responseType: Model.Type,
                                      url: URL?,
                                      completion: @escaping (ServiceResponse<Model>) -> Void)
}

final class WebService: BaseService {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func callEndpoint<Model: Codable>(responseType: Model.Type,
                              url: URL?,
                              completion: @escaping (ServiceResponse<Model>) -> Void) {
        
        guard let url = url else {
            completion(.failure(error: AppError.wrongURL))
            return
        }
            
        let task = getDataTask(url: url) { [weak self] (data, error) in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            
            self?.decodeData(data: data, completion: completion)
        }
        
        task.resume()
    }
    
    private func getDataTask(url: URL, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return urlSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(nil, AppError.server)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<400 ~= httpResponse.statusCode),
                let data = data else {
                    completion(nil, AppError.server)
                    return
            }
            
            completion(data, nil)
        }
    }
    
    private func decodeData<Model: Codable>(data: Data?, completion: @escaping (ServiceResponse<Model>) -> Void) {
        
        guard let data = data,
            let dataModel = try? JSONDecoder().decode(Model.self, from: data) else {
                completion(.failure(error: AppError.decode))
                return
        }
        
        completion(.success(response: dataModel))
    }
}
