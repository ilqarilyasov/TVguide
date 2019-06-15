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
    
    
    // MARK: - Fetching data
    
    func fetchTVShows(completion: @escaping (Result<TVShows, Error>) -> Void) {
        let requestURL = getURL()
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error performing data task: \(error)")
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse{
                NSLog("Fetch TVShows URL response: \(response.statusCode)")
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.IIlyasov.TVguide.ErrorDomain", code: -1, userInfo: nil)
                NSLog("No data returned: \(error)")
                completion(.failure(error))
                return
            }
            
            do {
                let tvshows = try JSONDecoder().decode(TVShows.self, from: data)
                completion(.success(tvshows))
            } catch {
                NSLog("Error decoding JSON to TVshows: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    // MARK: - Helper
    
    private func getURL() -> URL {
        let url = baseURL.appendingPathComponent("tvshows")
            .appendingPathExtension("json")
        return url
    }
}
