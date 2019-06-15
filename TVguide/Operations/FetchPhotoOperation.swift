//
//  FetchPhotoOperation.swift
//  TVguide
//
//  Created by Ilgar Ilyasov on 6/15/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class FetchPhotoOperation: ConcurrentOperation {
    
    private let show: Show
    private let session: URLSession
    private(set) var image: UIImage?
    private var dataTask: URLSessionDataTask?
    
    init(show: Show, session: URLSession = URLSession.shared) {
        self.show = show
        self.session = session
        super.init()
    }
    
    override func start() {
        state = .isExecuting
        
        let url = URL(string: show.imageURL)!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            defer { self.state = .isFinished }
            
            if self.isCancelled { return }
            
            if let error = error {
                NSLog("Error fetching data for \(self.show.name): \(error)")
                return
            }
            
            if let data = data {
                self.image = UIImage(data: data)
            }
        }
        
        task.resume()
        dataTask = task
    }
    
    override func cancel() {
        dataTask?.cancel()
        super.cancel()
    }
    
}
