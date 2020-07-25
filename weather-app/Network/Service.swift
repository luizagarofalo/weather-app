//
//  Service.swift
//  weather-app
//
//  Created by Luiza Collado Garofalo on 20/07/20.
//  Copyright © 2020 Luiza Collado Garofalo. All rights reserved.
//

import Foundation

class Service {
    func request<T: Codable>(router: Router, completion: @escaping (Result<T, CustomError>) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.network))
                return
            }
            
            guard response != nil else {
                completion(.failure(.api))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                completion(.failure(.parse))
                debugPrint("– JSONDecoder – \(T.self): \(error)")
            }
        }
        
        dataTask.resume()
    }
}
