//
//  UIImageView+MemoryCache.swift
//  Films
//
//  Created by Christian Ampe on 5/28/19.
//  Copyright © 2019 christianampe. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
    private static let memoryCache = CRAMemoryCache<UIImage>()
    private static let networkingService = CRANetworkingService()
}

extension UIImageView {
    func setImage(with url: URL) {
        let cacheKey = url.absoluteString
        
        if let cachedImage = UIImageView.memoryCache.object(forKey: cacheKey) {
            image = cachedImage
        } else {
            UIImageView.networkingService.request(URLRequest(url: url)) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let response):
                        guard let fetchedImage = UIImage(data: response.data) else {
                            return
                        }
                        
                        self.image = fetchedImage
                        UIImageView.memoryCache.setObject(fetchedImage, forKey: cacheKey)
                    case .failure:
                        break
                    }
                }
            }
        }
    }
}
