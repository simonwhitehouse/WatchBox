//
//  File.swift
//  
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

public class ImageStore {

    public static let shared = ImageStore()

    private let cache: NSCache<NSString, UIImage>

    public init(cache: NSCache<NSString, UIImage> = NSCache()) {
        self.cache = cache
    }

    public func image(for identifier: NSString) -> UIImage? {
        return cache.object(forKey: identifier)
    }

    public func store(image: UIImage, for key: NSString) {
        cache.setObject(image, forKey: key)
    }
}
