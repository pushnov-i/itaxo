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
        overrideUserInterfaceStyle = .light
        configureCollectionView()
        
    }
    
    func configureCollectionView() {
        //MARK Cant add constraits for collection view by Snapkit makeCostrains
        
        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 300)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RideListCell.self, forCellWithReuseIdentifier: reuseIdentifierRideListCell)
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
    func configureTopHeaderTableView() -> UIView?  {
          
          var viewModel : SettingsHeaderTopDelegate?
          let headerView = SettingsTopHeaderViewComponent(frame: .zero)
          // добавляем хендлер тапа для дисмиса экрана настроек
          let tap = UITapGestureRecognizer(target: self, action: #selector(dismissRideListView))
          headerView.button.addGestureRecognizer(tap)
//          tap.rx.event.bind(onNext: { recognizer in
//              print("cancel button")
//          }).disposed(by: disposeBag)
          
          viewModel = SettingsViewModel.HeaderSettings()
          if let viewModel = viewModel {
              headerView.configure(withViewModel: viewModel )
          }
          
          return headerView
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierRideListCell, for: indexPath) as! RideListCell
        return cell
    }
    
    @objc func dismissRideListView() {
        dismiss(animated: true, completion: nil)
    }
    
}


