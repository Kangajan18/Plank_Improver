//
//  LoginTextField.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-22.
//

import UIKit

class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoginTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoginTextField() {
        backgroundColor = .black
        layer.opacity = 0.5
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
        tintColor = .white
        layer.cornerRadius = 5
    }

}
