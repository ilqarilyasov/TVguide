//
//  ShowClient.swift
//  TVguide
//
//  Created by Ilgar Ilyasov on 6/15/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

class ShowClient {
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://ax-interview-questions.s3.amazonaws.com")!
    
    private func getURL() -> URL {
        let url = baseURL.appendingPathComponent("tvshows")
            .appendingPathExtension("json")
        return url
    }
    
    func fetchTVShows(completion: @escaping (Result<TVShows, Error>) -> Void) {
        let requestURL = getURL()
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse{
                NSLog("Response: \(response.statusCode)")
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            do {
                let tvshows = try JSONDecoder().decode(TVShows.self, from: data)
                completion(.success(tvshows))
            } catch {
                NSLog("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
