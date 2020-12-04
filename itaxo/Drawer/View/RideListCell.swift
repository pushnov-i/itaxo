//
//  RdieListCell.swift
//  itaxo
//
//  Created by Genuine on 25.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit

let imagePinFrom = UIImage(named: "rideList/pinFrom")
let imagePinTo = UIImage(named: "rideList/pinTo")
let imageUAHIcon = UIImage(named: "rideList/UAHIcon")
let imageCardIcon = UIImage(named: "rideList/cardIcon")

class RideListCell : UICollectionViewCell {
    
    let dateTimeLabel : UILabel = {
        let dateTimeView = UILabel()
        dateTimeView.contentMode = .scaleAspectFit
        dateTimeView.clipsToBounds = false
        //  dateTimeView.text = "13.05.2020, 17:25"
        return dateTimeView
    }()
    let lengthRide : UILabel = {
        let lengthRideView = UILabel()
        lengthRideView.contentMode = .scaleAspectFit
        lengthRideView.clipsToBounds = false
        //   lengthRideView.text = "11.1 км"
        lengthRideView.textColor = UIColor(hex: "#818181ff")
        lengthRideView.textAlignment = .right
        return lengthRideView
    }()
    
    lazy var dateLengthStackView: UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = false 
        stack.axis = .horizontal
        stack.spacing = 30
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFit
        [self.dateTimeLabel,
         self.lengthRide,
            ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    
    let fromLocationImageLabel: UIImageView = {
        let fromLocationIconView = UIImageView(image: imagePinFrom)
        fromLocationIconView.contentMode = .scaleAspectFit
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    
    var fromLocationTextLabel: UILabel = {
        let fromLocationTextView = UILabel()
        fromLocationTextView.contentMode = .scaleAspectFill
        fromLocationTextView.clipsToBounds = true
        
        return fromLocationTextView
    }()
    let toLocationImageLabel: UIImageView = {
        let fromLocationIconView = UIImageView(image: imagePinTo)
        fromLocationIconView.contentMode = .scaleAspectFill
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    
    var toLocationTextLabel: UILabel = {
        let fromLocationTextView = UILabel()
        fromLocationTextView.contentMode = .scaleAspectFill
        fromLocationTextView.clipsToBounds = true
        return fromLocationTextView
    }()
    
    
    
    lazy var fromLocationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 25
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.contentMode = .scaleAspectFill
        stack.addArrangedSubview(fromLocationImageLabel)
        stack.addArrangedSubview(fromLocationTextLabel)
        
        fromLocationImageLabel.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(20)
        }
        return stack
    }()
    
    
    lazy var toLocationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 25
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.contentMode = .scaleAspectFill
        stack.addArrangedSubview(toLocationImageLabel)
        stack.addArrangedSubview(toLocationTextLabel)
        toLocationImageLabel.snp.makeConstraints{(make) -> Void in
              make.width.equalTo(20)
          }
        return stack
    }()
    
    let currencyIcon: UIImageView = {
        let fromLocationIconView = UIImageView(image: imageUAHIcon)
        fromLocationIconView.contentMode = .scaleAspectFill
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    let paymentMetodIcon: UIImageView = {
        let fromLocationIconView = UIImageView(image: imageCardIcon)
        fromLocationIconView.contentMode = .scaleAspectFill
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    
    var  priceLabel: UILabel = {
        let fromLocationTextView = UILabel()
        fromLocationTextView.text = "106"
        guard let customFont = UIFont(name: "Roboto-Regular", size: 29) else {
            fatalError("""
            Failed to load the "Roboto-Regular" font.
            """
            )
        }
        fromLocationTextView.font = UIFontMetrics.default.scaledFont(for: customFont)
        fromLocationTextView.contentMode = .scaleAspectFill
        fromLocationTextView.clipsToBounds = true
        return fromLocationTextView
    }()
    
    lazy var paymentStackView: UIStackView = {
        let placeholder = UIView()
        placeholder.setContentHuggingPriority(.defaultLow, for: .horizontal)
        placeholder.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .center
        stack.contentMode = .scaleAspectFill
        stack.addArrangedSubview(currencyIcon)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(paymentMetodIcon)
        stack.addArrangedSubview(placeholder)
        
        
        return stack
    }()
    
    let returnTripButton : UIButton! = {
        let returnImageView = UIImage(named: "rideList/arrowsIcon")
        let button = UIButton(type: .custom)
        button.setImage(returnImageView, for: .normal)
        button.setTitle("У зворотній бік", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#EAEAEAff")
        button.titleEdgeInsets = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 10)
        button.layer.cornerRadius = 25
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        //adding shadow
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.5
        
        return button
    }()
    
    let repeatTripButton : UIButton! = {
        let button = UIButton(type: .custom)
        button.setTitle("Повторити", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hex: "#FFDE43ff")
        button.titleEdgeInsets = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 10)
        button.layer.cornerRadius = 25
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        //adding shadow
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.5
        
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.contentMode = .scaleAspectFill
        stack.addArrangedSubview(returnTripButton)
        stack.addArrangedSubview(repeatTripButton)
        return stack
    }()
    
    
    override init(frame:CGRect) {
        print(fromLocationTextLabel.text)
        
        super.init(frame: .zero)
        contentView.contentMode = .scaleAspectFill
        contentView.addSubview(dateLengthStackView)
        contentView.addSubview(fromLocationStackView)
        contentView.addSubview(toLocationStackView)
        contentView.addSubview(paymentStackView)
        contentView.addSubview(buttonStackView)
        dateLengthStackView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        dateLengthStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.centerY.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            
        }
        
        
        fromLocationStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.centerY.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            
        }
        
        toLocationStackView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        toLocationStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview().inset(30)
            make.centerY.equalToSuperview().offset(-0)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.centerX.equalToSuperview()
            
        }
        
        paymentStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(35)
            make.width.equalToSuperview().inset(30)
            make.centerY.equalToSuperview().offset(40)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.centerX.equalToSuperview()
            
        }
        
        
        buttonStackView.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalToSuperview().inset(20)
            make.centerY.equalToSuperview().offset(90)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.centerX.equalToSuperview()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
