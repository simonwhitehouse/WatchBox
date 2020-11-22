//
//  Reuseable.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 22/11/2020.
//

import UIKit

public protocol Reuseable {
    static var reuseIdentifier: String { get }
}

extension Reuseable where Self: UITableViewCell {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
