//
//  RdieListCell.swift
//  itaxo
//
//  Created by Genuine on 25.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit

class RideListCell : UICollectionViewCell {
    
    let dateTimeLabel : UILabel = {
        let dateTimeView = UILabel()
        dateTimeView.contentMode = .scaleAspectFit
        dateTimeView.clipsToBounds = false
        dateTimeView.text = "13.05.2020, 17:25"
        return dateTimeView
    }()
    let lengthRide : UILabel = {
        let lengthRideView = UILabel()
        lengthRideView.contentMode = .scaleAspectFit
        lengthRideView.clipsToBounds = false
        lengthRideView.text = "11.1 км"
        lengthRideView.textAlignment = .right
        //        lengthRideView.snp.makeConstraints{ (make)-> Void in
        //            make.trailing.equalToSuperview()
        //        }
        return lengthRideView
    }()
    
    lazy var dateLengthStackView: UIStackView = {
        let stack = UIStackView()
        stack.clipsToBounds = false 
        stack.axis = .horizontal
        stack.spacing = 100
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFit
        [self.dateTimeLabel,
         self.lengthRide,
            ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    
    let fromLocationImageLabel: UIImageView = {
        let image = UIImage(named: "rideList/pinFrom")
        let fromLocationIconView = UIImageView(image: image)
        fromLocationIconView.contentMode = .scaleAspectFit
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    
    var fromLocationTextLabel: UILabel = {
        let fromLocationTextView = UILabel()
        fromLocationTextView.text = "Київ, Гагаріна Юрія проспект, 20"
        fromLocationTextView.contentMode = .scaleAspectFit
        fromLocationTextView.clipsToBounds = true
        return fromLocationTextView
    }()
    let toLocationImageLabel: UIImageView = {
        let image = UIImage(named: "rideList/pinTo")
        let fromLocationIconView = UIImageView(image: image)
        fromLocationIconView.contentMode = .scaleAspectFit
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    
    var toLocationTextLabel: UILabel = {
        let fromLocationTextView = UILabel()
        fromLocationTextView.text = "Київ, Парк Дружби народів"
        fromLocationTextView.contentMode = .scaleAspectFit
        fromLocationTextView.clipsToBounds = true
        return fromLocationTextView
    }()
    
    
    
    lazy var fromLocationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.contentMode = .scaleAspectFit
        stack.addArrangedSubview(fromLocationImageLabel)
        stack.addArrangedSubview(fromLocationTextLabel)
        return stack
    }()
    
    
    lazy var toLocationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.contentMode = .scaleAspectFit
        stack.addArrangedSubview(toLocationImageLabel)
        stack.addArrangedSubview(toLocationTextLabel)
        return stack
    }()
    
    let currencyIcon: UIImageView = {
        let image = UIImage(named: "rideList/UAHIcon")
        let fromLocationIconView = UIImageView(image: image)
        // self.view .addSubview(fromLocationIconView)
        
        fromLocationIconView.contentMode = .scaleAspectFit
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    let paymentMetodIcon: UIImageView = {
        let image = UIImage(named: "rideList/cardIcon")
        let fromLocationIconView = UIImageView(image: image)
        // self.view .addSubview(fromLocationIconView)
        
        fromLocationIconView.contentMode = .scaleAspectFit
        fromLocationIconView.clipsToBounds = true
        return fromLocationIconView
    }()
    
    var  priceLabel: UILabel = {
        let fromLocationTextView = UILabel()
        fromLocationTextView.text = "106"
        fromLocationTextView.contentMode = .scaleAspectFit
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
        stack.alignment = .trailing
        // stack.distribution = .equalSpacing
        stack.contentMode = .scaleAspectFit
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
        stack.contentMode = .scaleAspectFit
        stack.addArrangedSubview(returnTripButton)
        stack.addArrangedSubview(repeatTripButton)
        return stack
    }()
    
    
    override init(frame:CGRect) {
        
        super.init(frame: .zero)
        contentView.addSubview(dateLengthStackView)
        contentView.addSubview(fromLocationStackView)
        contentView.addSubview(toLocationStackView)
        contentView.addSubview(paymentStackView)
        contentView.addSubview(buttonStackView)
        dateLengthStackView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        dateLengthStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
            make.centerX.equalToSuperview()
            
        }
        
        
        fromLocationStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            
        }
        
        toLocationStackView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        toLocationStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(-0)
            make.centerX.equalToSuperview()
            
        }
        
        paymentStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(35)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            
        }
        
        
        buttonStackView.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
