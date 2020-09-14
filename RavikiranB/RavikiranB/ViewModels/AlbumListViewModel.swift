//
//  AlbumListViewModel.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import Foundation

enum SortType:Int {
    case CollectionName = 0
    case TrackName
    case ArtistName
    case Price
}

struct AlbumListViewModel {
    
    //MARK:- Initializer
    init(_ albums:[Album]) {
        self.albums = albums
        filterAlbums()
        sortAlbums(nil)
    }
    
    
    //MARK:- Functions
    private var albums:[Album]
    private var filteredAlbums:[Album] = []
    var filterOptions:SearchOptionViewModel?
    
    //MARK:- Functions
    
    
    func numberOfAlbums() -> Int {
        return self.filteredAlbums.count
    }
    
    
    func albumAtIndex(_ Index:Int) -> AlbumViewModel {
        let album = filteredAlbums[Index]
        return AlbumViewModel.init(album)
    }
    
    func selectAlbumAtIndex(_ Index:Int) {
        let album = filteredAlbums[Index]
        album.isSelected = !album.isSelected
    }
    
    mutating func filterAlbums() {
        if let options = filterOptions {
            let albums = self.albums
            self.filteredAlbums = albums.filter { (album) -> Bool in
                
                if options.artistName.count > 0 {
                    if options.artistName.lowercased() != album.artistName.lowercased() {
                        return false
                    }
                }
                
                if options.trackName.count > 0 {
                    if options.trackName.lowercased() != album.trackName.lowercased() {
                        return false
                    }
                }
                
                if (options.collectionName?.count ?? 0) > 0 {
                    if options.collectionName?.lowercased() != album.collectionName.lowercased() {
                        return false
                    }
                }
                
                if (options.collectionPrice ?? 0.0) > 0.0 {
                    if (options.collectionPrice ?? 0.0) < (album.collectionPrice){
                        return false
                    }
                }
                
                if let date = options.releaseDate {
                    if album.releaseDate?.compare(date) == ComparisonResult.orderedAscending {
                        return false
                    }
                }
                
                return true
            }
        }
        else {
            self.filteredAlbums = self.albums
        }
    }
    
    mutating func sortAlbums(_ type: SortType?){
        var albums = self.filteredAlbums
        switch type {
        case .ArtistName:
            albums.sort { (alb1, alb2) -> Bool in
                return alb1.artistName < alb2.artistName
            }
        case .CollectionName:
            albums.sort { (alb1, alb2) -> Bool in
                return alb1.collectionName < alb2.collectionName
            }
        case .TrackName:
            albums.sort { (alb1, alb2) -> Bool in
                return alb1.trackName < alb2.trackName
            }
        case .Price:
            albums.sort { (alb1, alb2) -> Bool in
                return alb1.collectionPrice > alb2.collectionPrice
            }
        default:
            albums.sort { (alb1, alb2) -> Bool in
                if let date1 = alb1.releaseDate, let date2 = alb2.releaseDate {
                    return date1.compare(date2) == ComparisonResult.orderedDescending
                }
                return false
            }
        }
        self.filteredAlbums = albums
    }
    
}
