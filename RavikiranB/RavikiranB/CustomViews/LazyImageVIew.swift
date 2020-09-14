//
//  LazyImageVIew.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import UIKit


class LazyImageView: UIImageView {
    var imageUrl:String? {
        didSet {
            if let url = imageUrl {
                self.obtainImageWithPath(imagePath: url)
            }
        }
    }
    var cache: NSCache<NSString, UIImage>!
    
    
    func obtainImageWithPath(imagePath: String) {
        if self.cache == nil {
            self.cache = NSCache()
        }
        if let image = self.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            
            let url: URL! = URL(string: imagePath)
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: imagePath as NSString)
                    if response?.url?.absoluteString == self.imageUrl {
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                    else if let imageUrl = self.imageUrl{
                        self.obtainImageWithPath(imagePath: imageUrl)
                    }
                    
                }
            }.resume()
           
        }
    }
}
