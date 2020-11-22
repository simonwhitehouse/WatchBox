//
//  RateMovieTableViewCell.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 22/11/2020.
//

import UIKit

public class RateMovieTableViewCell: UITableViewCell, Reuseable {

    private var ratingButtons = [UIButton]()
    private var exsistingRating: Int16 = 0 {
        didSet {
            updateRateButtonStates()
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    public var ratingChangedHandler: ((Int16) -> Void)?

    public func configure(with rating: Int16) {
        configureUI()
        exsistingRating = rating
    }

    private func configureUI() {
        if stackView.superview == nil {
            contentView.addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }

        setUpButtons()
    }

    @objc
    func ratingButtonPressed(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            return
        }

        exsistingRating = (Int16(index) + 1 == exsistingRating) ? 0 : Int16(index) + 1
        ratingChangedHandler?(exsistingRating)
    }

    private let filledStarImage = UIImage(systemName: "star.fill")
    private let StarImage = UIImage(systemName: "star")

    private func setUpButtons() {
        ratingButtons.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        ratingButtons = []

        for _ in 0..<5 {
            let button = UIButton()

            button.setImage(StarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true

            button.addTarget(self, action: #selector(RateMovieTableViewCell.ratingButtonPressed(button:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }

    private func updateRateButtonStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < exsistingRating
        }
    }
}
