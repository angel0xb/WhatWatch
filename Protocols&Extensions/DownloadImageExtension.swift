//
//  DownloadImageExtension.swift
//  WhatWatch
//
//  Created by Angel Rodriguez on 5/8/18.
//  Copyright © 2018 Angel Rodriguez. All rights reserved.
//


import Foundation

import UIKit

extension UIImageView {
    
    func loadImageUsingCacheWithUrl(url : URL, completion: @escaping (_ success: Bool)->() )
    {
        let urlString = url.absoluteString
        self.image = Constants.Image.noPhoto;
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject)  as? UIImage {
            self.image = cachedImage;
            //            print("I have been already saved")
            completion(true)
            
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                completion(false)
                
            }
            
            DispatchQueue.main.async {
                guard let data = data else{return}
                if  let downloadedImage = UIImage(data: data){
                    //                    print("Done")
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                    completion(true)
                }
                
            }
        }).resume()
    }
    
}
