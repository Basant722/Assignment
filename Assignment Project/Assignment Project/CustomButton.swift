//
//  CustomButton.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.
//

//import UIKit
//
//class CustomButton: UIButton {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//    
//    private func setup() {
//        setTitleColor(.white, for: .normal)
//        backgroundColor = .systemBlue
//        layer.cornerRadius = 5
//        clipsToBounds = true
//    }
//}


import UIKit

class CustomButton: UIButton {

    private var gradientLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10 // Adjusted for a more pronounced rounded effect
        clipsToBounds = true

        // Create and configure the gradient layer
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor] // Customize your colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)

        // Add touch animations
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the gradient layer's frame on layout changes
        gradientLayer.frame = bounds
    }

    @objc private func touchDown() {
        // Scale down the button slightly on touch down
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }

    @objc private func touchUp() {
        // Scale the button back to its original size
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
