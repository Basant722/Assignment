//
//  CustomButton.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.
//


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
        layer.cornerRadius = 10
        clipsToBounds = true
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPurple.cgColor] //
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside])
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    

    @objc private func touchDown() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    

    @objc private func touchUp() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
