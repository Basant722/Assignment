//
//  Customtextfield.swift
//  Assignment Project
//
//  Created by Basant Kumar on 19/10/24.
//

//import UIKit
//
//class CustomTextField: UITextField {
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
//        borderStyle = .roundedRect
//        padding()
//    }
//    
//    private func padding() {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
//        leftView = paddingView
//        leftViewMode = .always
//    }
//}
import UIKit

class CustomTextField: UITextField {

    // Customizable properties for border color and placeholder font
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
        // Set up the text field's appearance
        layer.cornerRadius = 10 // Rounded corners
        layer.borderWidth = 1 // Border width
        layer.borderColor = borderColor.cgColor // Custom border color
        padding()
        
        // Set the default placeholder font
        updatePlaceholderFont()
        
        // Set text color
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
                .foregroundColor: UIColor.lightGray // You can customize the placeholder color here
            ]
            attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        }
    }
}
