//
//  FavoruitesMoveListViewController.swift
//  WatchBox
//
//  Created by Simon Whitehouse on 20/11/2020.
//

import UIKit

public class FavoruitesMoveListViewController: UIViewController {

    private let viewModel: FavoruitesMoveListViewModel

    public init(viewModel: FavoruitesMoveListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }

}
