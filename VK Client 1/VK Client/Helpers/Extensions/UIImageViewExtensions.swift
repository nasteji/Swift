//
//  UIImageViewExtensions.swift
//  VK Client
//
//  Created by Анастасия Живаева on 21.06.2021.
//

import UIKit

extension UIImageView {

    func loadImage(imageUrl: String) {

        guard let url = URL(string: imageUrl) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if let imageData = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageData)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, let response = response
                else {
                    print("error", error?.localizedDescription ?? "not localizedDescription")
                    return
                }
                let cacheResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cacheResponse, for: request)
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
