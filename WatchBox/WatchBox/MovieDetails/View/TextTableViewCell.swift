//
//  TextTableViewCell.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

public class TextTableViewCell: UITableViewCell, Reuseable {

    public func configure(text: String, textAlignment: NSTextAlignment = .left) {
        selectionStyle = .none
        textLabel?.numberOfLines = 0
        textLabel?.font = .preferredFont(forTextStyle: .body)
        textLabel?.textColor = .secondaryLabel
        textLabel?.text = text
        textLabel?.textAlignment = textAlignment
    }
}
