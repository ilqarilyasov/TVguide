//
//  ShowTableViewCell.swift
//  TVguide
//
//  Created by Ilgar Ilyasov on 6/15/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let photoFetchQueue = OperationQueue()
    var show: Show? {
        didSet { updateView() }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var tvChannelLabel: UILabel!
    
    
    // MARK: - Update views
    
    private func updateView() {
        guard let show = show else { return }
        
        showNameLabel.text = show.name
        tvChannelLabel.text = show.tvChannel
        
        
        let fetchOp = FetchPhotoOperation(show: show)
        let completionOp = BlockOperation {
            if let image = fetchOp.image {
                self.showImageView.image = image
            }
        }
        
        completionOp.addDependency(fetchOp)
        photoFetchQueue.addOperation(fetchOp)
        OperationQueue.main.addOperation(completionOp)
    }
    
}
