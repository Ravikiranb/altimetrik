//
//  WebService.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import Foundation


class WebService {
    
    func getAlbums(completion:@escaping (([Album]?) -> ())) {
        let url = URL(string: "https://itunes.apple.com/search?term=all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let albumList = try? JSONDecoder().decode(AlbumList.self, from: data) {
                    DispatchQueue.main.async {
                        completion(albumList.results)
                    }
                    
                }
                else {
                    completion(nil)
                }
                
                
            }
            else {
                completion(nil)
            }
        }.resume()
    }
}
