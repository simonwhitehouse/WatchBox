//
//  LoadingTableViewCell.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 22/11/2020.
//

import UIKit

public class LoadingTableViewCell: UITableViewCell, Reuseable {

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    public func configure() {
        if activityIndicator.superview == nil {
            contentView.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                activityIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                activityIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }
        activityIndicator.startAnimating()
    }
}
