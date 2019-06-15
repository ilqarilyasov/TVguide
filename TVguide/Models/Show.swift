//
//  Show.swift
//  TVguide
//
//  Created by Ilgar Ilyasov on 6/15/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

typealias TVShows = [Show]

struct Show: Decodable {
    let identifier: Int
    let imageURL: String
    let link: String
    let name: String
    let tvChannel: String
    
    let description: String?
    let episodes: [Episode]?
    
    enum CodingKeys: String, CodingKey {
        case identifier = "num"
        case imageURL = "img"
        case link = "lnk"
        case name = "name"
        case tvChannel = "air"
        case description = "desc"
        case episodes = "listings"
    }
}
