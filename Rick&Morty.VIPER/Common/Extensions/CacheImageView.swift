//
//  UIImage+Alamofire.swift
//  Rick&Morty.VIPER
//
//  Created by Alvaro on 23/01/2021.
//  Copyright © 2021 Alvaro Orti Moreno. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

final class CacheImageView: UIImageView {
    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    let activityIndicator = UIActivityIndicatorView()
    
    func download(imageURL: String) {
        activityIndicator.color = .darkGray
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            
        image = nil
        activityIndicator.startAnimating()
 
        if let image = imageCache.image(withIdentifier: imageURL) {
            self.image = image
            activityIndicator.stopAnimating()
        }
        
        AF.request(imageURL).responseImage { [weak self] (response) in
            switch response.result {
            case .success(let image):
                self?.activityIndicator.stopAnimating()
                self?.imageCache.add(image, withIdentifier: imageURL)
                self?.image = image
            case .failure(_):
                self?.activityIndicator.stopAnimating()
                self?.image = nil
            }
        }
    }
}
