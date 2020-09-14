//
//  Album.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import Foundation


struct AlbumList: Decodable {
    let results:[Album]
}


class Album: Decodable {
    let trackId:Int
    let artistName:String
    let trackName:String
    let collectionName:String
    let collectionPrice:Double
    let releaseDate:Date?
    let albumImageUrl:String
    
    var isSelected:Bool = false
    
    enum CodingKeys: String, CodingKey {
        case trackId
        case artistName
        case trackName
        case collectionName
        case collectionPrice
        case releaseDate
        case albumImageUrl = "artworkUrl100"
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        trackId = try container.decode(Int.self, forKey: .trackId)
        artistName = try container.decode(String.self, forKey: .artistName)
        trackName = try container.decode(String.self, forKey: .trackName)
        collectionName = try container.decode(String.self, forKey: .collectionName)
        collectionPrice = try container.decode(Double.self, forKey: .collectionPrice)
        albumImageUrl = try container.decode(String.self, forKey: .albumImageUrl)
        
        let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        releaseDate = dateFormatter.date(from: releaseDateString)
        
    }
}

