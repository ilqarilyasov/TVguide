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
        
        // TODO: - Load image
    }
    
}
