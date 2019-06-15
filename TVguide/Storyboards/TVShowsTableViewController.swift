//
//  TVShowsTableViewController.swift
//  TVguide
//
//  Created by Ilgar Ilyasov on 6/15/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class TVShowsTableViewController: UITableViewController {
    
    private let client = ShowClient()
    private let showCellReuseIdentifier = "ShowCell"
    private var tvShows = TVShows() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        client.fetchTVShows { (result) in
            switch result{
            case .failure(let error):
                NSLog("Error: \(error)")
                // Show informative alert
            case .success(let tvShows):
                self.tvShows = tvShows
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tvShows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: showCellReuseIdentifier, for: indexPath)
        
        let show = tvShows[indexPath.row]
        cell.textLabel?.text = show.name
        
        return cell
    }


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
