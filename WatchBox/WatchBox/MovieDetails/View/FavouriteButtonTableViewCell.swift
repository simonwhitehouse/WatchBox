//
//  FavouriteButtonTableViewCell.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

public class FavouriteButtonTableViewCell: UITableViewCell, Reuseable {

    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton()
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.setTitleColor(.systemYellow, for: .normal)
        favouriteButton.setTitle("Favourite", for: .normal)
        favouriteButton.layer.cornerRadius = 5
        favouriteButton.layer.borderWidth = 1
        favouriteButton.layer.borderColor = UIColor.systemYellow.cgColor
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        return favouriteButton
    }()

    private var isFavourite: Bool = false
    public var favouriteButtonPressedHandler: ((_ isFavourite: Bool) -> Void)?

    public func configure(isFavourite: Bool) {
        selectionStyle = .none
        self.isFavourite = isFavourite
        if favouriteButton.superview == nil {
            contentView.addSubview(favouriteButton)
            NSLayoutConstraint.activate([
                favouriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                favouriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }

        configureButton(isFavourite: isFavourite)
    }

    private func configureButton(isFavourite: Bool) {
        favouriteButton.setTitle(isFavourite ? "Remove Favourite" : "Add Favourite", for: .normal)
        favouriteButton.layer.borderColor = !isFavourite ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        favouriteButton.setTitleColor(!isFavourite ? UIColor.systemGreen : UIColor.systemRed, for: .normal)
    }

    @objc
    private func favouriteButtonPressed() {
        favouriteButtonPressedHandler?(isFavourite)
        isFavourite.toggle()
        configureButton(isFavourite: isFavourite)
    }
}
