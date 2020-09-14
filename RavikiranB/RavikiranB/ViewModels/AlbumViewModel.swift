//
//  AlbumViewModel.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import Foundation

struct AlbumViewModel {
    private let album: Album
    
    init(_ album: Album) {
        self.album = album
    }
}


extension AlbumViewModel {
    
    var trackName: String {
        return album.trackName
    }
    
    var artistName: String {
        return album.artistName
    }
    
    var collectionName: String {
        return album.collectionName
    }
    
    var collectionPrice: String {
        return String(format: "%.2f", album.collectionPrice)
    }
    
    var imageUrl: String {
        return album.albumImageUrl
    }
    
    var releaseDate:String {
        guard let date = album.releaseDate else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy"
        return formatter.string(from: date)
    }
    
    var isSelected:Bool {
        return album.isSelected
    }
}
