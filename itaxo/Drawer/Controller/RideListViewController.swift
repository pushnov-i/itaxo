//
//  RideListViewController.swift
//  itaxo
//
//  Created by Genuine on 25.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit



class RideListViewController :  UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView : UICollectionView!
    var reuseIdentifierRideListCell = "rideListCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 150)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RideListCell.self, forCellWithReuseIdentifier: reuseIdentifierRideListCell)
        
        //        collectionView.snp.makeConstraints{(make) -> Void in
        //
        //            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
        //            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
        //            make.top.equalTo( self.view.safeAreaLayoutGuide.snp.topMargin).inset(20)
        //            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
        //        }
        view.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierRideListCell, for: indexPath) as! RideListCell
        return cell
    }
    
}


