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
        dateTimeView.clipsToBounds = true
        dateTimeView.text = "13.05.2020, 17:25"
        return dateTimeView
    }()
    let lengthRide : UILabel = {
        let lengthRideView = UILabel()
        lengthRideView.contentMode = .scaleAspectFit
        lengthRideView.clipsToBounds = true
        lengthRideView.text = "11.1 км"
        lengthRideView.textAlignment = .right
        //        lengthRideView.snp.makeConstraints{ (make)-> Void in
        //            make.trailing.equalToSuperview()
        //        }
        return lengthRideView
    }()
    
    lazy var dateLengthStackView: UIStackView = {
        let stack = UIStackView()
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
        let image = UIImage(named: "rideList/pinTo")
        let fromLocationIconView = UIImageView(image: image)
       // self.view .addSubview(fromLocationIconView)
        
       // fromLocationIconView.contentMode = .scaleAspectFit
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
    
    
    
    override init(frame:CGRect) {
        
        super.init(frame: .zero)
        contentView.addSubview(dateLengthStackView)
        contentView.addSubview(fromLocationStackView)
        dateLengthStackView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        dateLengthStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(-75)
            make.centerX.equalToSuperview()
            
        }
        
        fromLocationStackView.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        fromLocationStackView.snp.makeConstraints{(make) -> Void in
            
            make.height.equalTo(30)
            make.width.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
