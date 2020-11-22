//
//  FavouriteMovieListTableViewCell.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 21/11/2020.
//

import UIKit

import WBData
import WBNetworking

public class FavouriteMovieListTableViewCell: UITableViewCell, Reuseable {

    private lazy var posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        return posterImageView
    }()

    private lazy var horizontalStack: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.spacing = 8

        horizontalStack.addArrangedSubview(self.posterImageView)
        horizontalStack.addArrangedSubview(self.verticalStack)

        posterImageView.heightAnchor.constraint(lessThanOrEqualTo: posterImageView.widthAnchor, multiplier: 4/3).isActive = true
        posterImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 80).isActive = true
        return horizontalStack
    }()

    private lazy var verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 4

        verticalStack.addArrangedSubview(self.titleLabel)
        verticalStack.addArrangedSubview(self.releasedYearLabel)
        verticalStack.addArrangedSubview(self.plotLabel)
        return verticalStack
    }()

    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.numberOfLines = 3
        return titleLabel
    }()

    private lazy var releasedYearLabel: UILabel = {
        let releasedYearLabel = UILabel()
        releasedYearLabel.translatesAutoresizingMaskIntoConstraints = false
        releasedYearLabel.font = .preferredFont(forTextStyle: .caption1)
        releasedYearLabel.textColor = .secondaryLabel
        releasedYearLabel.numberOfLines = 1
        return releasedYearLabel
    }()

    private lazy var plotLabel: UILabel = {
        let plotLabel = UILabel()
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        plotLabel.font = .preferredFont(forTextStyle: .body)
        plotLabel.textColor = .secondaryLabel
        plotLabel.numberOfLines = 3
        return plotLabel
    }()

    var posterDownloadTask: URLSessionTask?

    func configure(movie: MovieRepresentable, hidePlot: Bool = false) {
        setUpUI()

        // Hide / Show elements
        posterImageView.isHidden = movie.posterURL == nil
        plotLabel.isHidden = hidePlot
        
        titleLabel.text = movie.title
        releasedYearLabel.text = movie.year
        plotLabel.text = movie.plot

        if movie.posterURL != nil {
            posterDownloadTask = MovieService().fetchMoviePoster(for: movie, completion: { [weak self] response in
                switch response {
                case .success(let image):
                    self?.posterImageView.image = image
                case .failure(let error):
                    // TODO: Show error to user maybe?
                    self?.posterImageView.isHidden = true
                }
            })
        }
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        posterDownloadTask?.cancel()
    }

    private func setUpUI() {
        if horizontalStack.superview == nil {
            contentView.addSubview(horizontalStack)
            NSLayoutConstraint.activate([
                horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    }

}
