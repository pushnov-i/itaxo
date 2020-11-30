//
//  RideListViewController.swift
//  itaxo
//
//  Created by Genuine on 25.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit



class RideListViewController :  UICollectionViewController,UICollectionViewDelegateFlowLayout {
    // var collectionView : UICollectionView!
    var reuseIdentifierRideListCell = "rideListCell"
    var headerIdentifier = "rideListHeaderView"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureCollectionView()
        
    }
    
    
    func configureCollectionView() {
        
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RideListCell.self, forCellWithReuseIdentifier: reuseIdentifierRideListCell)
        collectionView.register(RideListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.backgroundColor = .white
        // collectionView.
        view.backgroundColor = yellowBackground
        //                collectionView.snp.makeConstraints{(make) -> Void in
        //
        //                    make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
        //                    make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
        //                    make.top.equalTo( self.view.safeAreaLayoutGuide.snp.topMargin).inset(20)
        //                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
        //                }
        view.addSubview(collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: headerIdentifier, for: indexPath) as? RideListHeaderView else{ return fatalError("error") as! UICollectionReusableView}
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierRideListCell, for: indexPath) as! RideListCell
        return cell
    }
    
    @objc func dismissRideListView() {
        dismiss(animated: true, completion: nil)
    }
}


