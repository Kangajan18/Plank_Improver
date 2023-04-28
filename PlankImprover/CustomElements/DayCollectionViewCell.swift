//
//  DayCollectionViewCell.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-25.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    //define UIElements
    lazy var dayTitle:UILabel = {
        var label = UILabel()
        label.text = "Day"
        label.textAlignment = .center
        label.font = UIFont(name: "LexendTera-ExtraBold", size: 15)
        return label
    }()
    
    lazy var doneImageView:UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    
    lazy var dayLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "LexendTera-ExtraBold", size: 30)
        return label
    }()
    
    lazy var currentSecond:UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "LexendTera-ExtraBold", size: 14)
        return label
    }()
    
    lazy var titleStackView : UIStackView = {
        var stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        stackview.addArrangedSubview(dayTitle)
        stackview.addArrangedSubview(doneImageView)
        stackview.widthAnchor.constraint(equalToConstant: 65).isActive = true
        return stackview
    }()
    
    lazy var stackView : UIStackView = {
        var stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillProportionally
        return stackview
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red:10, green:10 ,blue:10 , alpha:0.50)
        setupCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionViewCell() {
        self.layer.cornerRadius = 10
        
        
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(currentSecond)
        
        addSubview(stackView)
        
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                        
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupDayLabel(labelText:String) {
        dayLabel.text = labelText
    }
    
    func plankComplete(isComplete:Bool) {
        if isComplete{
            doneImageView.image = UIImage(imageLiteralResourceName: "done")
            self.isUserInteractionEnabled = false
        }else {
            doneImageView.image = .none
            self.isUserInteractionEnabled = true
        }
    }

}
