//
//  TVShowsTableViewController.swift
//  TVguide
//
//  Created by Ilgar Ilyasov on 6/15/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

class TVShowsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let client = ShowClient()
    private let showCellReuseIdentifier = "ShowCell"
    private let showCellNib = UINib(nibName: "ShowTableViewCell", bundle: nil)
    private var initialTVShows = TVShows()
    private var tvShows = TVShows() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var showsSearchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showsSearchBar.delegate = self
        tableView.register(showCellNib, forCellReuseIdentifier: showCellReuseIdentifier)
        
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
        return tvShows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: showCellReuseIdentifier, for: indexPath)
        
        guard let showCell = cell as? ShowTableViewCell else {
            fatalError("Couldn't configure custom show cell")
        }
        
        let show = tvShows[indexPath.row]
        showCell.show = show
        
        return showCell
    }

}

extension TVShowsTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        initialTVShows = tvShows
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            tvShows = initialTVShows
            return
        }
        
        tvShows = initialTVShows.filter { $0.name.lowercased().contains(searchText.lowercased())}
    }
}
