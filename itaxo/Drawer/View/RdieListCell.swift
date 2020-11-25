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
        return lengthRideView
    }()
    
    lazy var dateLengthStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 120
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFit
        [self.dateTimeLabel,
         self.lengthRide,
            ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    override init(frame:CGRect) {
    
        super.init(frame: .zero)
        contentView.addSubview(dateLengthStackView)
        dateLengthStackView.addBorder( side: .bottom, thickness: 10, color: UIColor.black)
        dateLengthStackView.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(100)
            make.width.equalTo(360)
            make.centerY.equalToSuperview()
            
        }
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}


}
