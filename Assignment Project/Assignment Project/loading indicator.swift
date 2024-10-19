//
//  loading indicator.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.
//

import UIKit

class LoadingIndicator: UIView {
    
    private let spinner = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 10
        addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func startAnimating() {
        isHidden = false
        spinner.startAnimating()
    }

    func stopAnimating() {
        isHidden = true
        spinner.stopAnimating()
    }
}
