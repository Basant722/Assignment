
//  Customtextfield.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.

import UIKit

class CustomTextField: UITextField {
    
    var borderColor: UIColor = .red {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    var placeholderFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            updatePlaceholderFont()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        padding()
        updatePlaceholderFont()
        textColor = .label
        backgroundColor = .systemBackground
    }
    
    
    private func padding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    private func updatePlaceholderFont() {
        if let placeholderText = placeholder {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: placeholderFont,
                .foregroundColor: UIColor.lightGray
            ]
            attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
    }
}
