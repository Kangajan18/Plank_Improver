//
//  LauncherButton.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-22.
//

import UIKit

class customBigButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        backgroundColor = .white
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIFont(name: "LexendTera-Light", size: 18)
        semanticContentAttribute = .forceRightToLeft
        layer.cornerRadius = 10
        
    }
}
