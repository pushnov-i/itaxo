//
//  RideListViewController.swift
//  itaxo
//
//  Created by Genuine on 25.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit
//import CoreData



class RideListViewController :  UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let reuseIdentifierRideListCell = "rideListCell"
    let headerIdentifier = "rideListHeaderView"
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureHeader()
        configureCollectionView()
        
        //     configureDataSource()
    }
    
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 100)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RideListCell.self, forCellWithReuseIdentifier: reuseIdentifierRideListCell)
        collectionView.register(RideListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = dataSource
        view.backgroundColor = yellowBackground
        //MARK: How to enaible snp.make constrainst instead of (let layout = UICollectionViewFlowLayout)?
        //                collectionView.snp.makeConstraints{(make) -> Void in
        //
        //                    make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
        //                    make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
        //                    make.top.equalTo( self.view.safeAreaLayoutGuide.snp.topMargin).inset(20)
        //                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
        //                }
        view.addSubview(collectionView)
        
    }
    
    func configureHeader() {
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            let header: RideListHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerIdentifier, for: indexPath) as! RideListHeaderView
            return header
        }
    }
    
    //    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        switch kind {
    //        case UICollectionView.elementKindSectionHeader:
    //            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! RideListHeaderView
    //            return headerView
    //        default:
    //            assert(false, "Unexpected element kind")
    //        }
    //    }
    //        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //            4
    //        }
    //
    
    //
    //    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierRideListCell, for: indexPath) as! RideListCell
    //       // cell.dateTimeLabel.text =
    //        return cell
    //    }
    //
    struct RideModel: Hashable {
        let dateTime: String
        let lengthRide: String
        let fromPlace : String
        let toPlace : String
        let price : String
    }
    
    struct RideList {
        var rideList : [RideModel] = [RideModel(dateTime: "3244t636456", lengthRide: "11", fromPlace: "one", toPlace: "two", price: "106"),
                                      RideModel(dateTime: "213123213", lengthRide: "12", fromPlace: "one", toPlace: "two", price: "2332")]
    }
    
    //    func configureDataSource(){
    //        let dataSource = UICollectionViewDiffableDataSource<Int,RideModel>(collectionView: collectionView) { (collectionView, indexPath, rideModel) -> UICollectionViewCell? in
    //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierRideListCell, for: indexPath) as! RideListCell
    //            cell.dateTimeLabel.text = rideModel.dateTime
    //            cell.lengthRide.text = rideModel.lengthRide
    //            cell.fromLocationTextLabel.text = rideModel.fromPlace
    //            cell.toLocationTextLabel.text = rideModel.toPlace
    //            return cell
    //        }
    //        var snapshot = NSDiffableDataSourceSnapshot<Int, RideModel>()
    //        snapshot.appendSections([1,2])
    //        snapshot.appendItems([RideModel(dateTime: "3244t636456", lengthRide: "11", fromPlace: "one", toPlace: "two", price: "106"),RideModel(dateTime: "213123213", lengthRide: "12", fromPlace: "one", toPlace: "two", price: "2332")], toSection: 1)
    //        // dataSource.apply(snapshot, animatingDifferences: true)
    //
    //        @available(iOS 13.0, *)
    //        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
    //            guard let dataSource = collectionView?.dataSource as? UICollectionViewDiffableDataSourceReference else {
    //                fatalError("The data source has not implemented snapshot support while it should")
    //            }
    //            dataSource.applySnapshot(snapshot, animatingDifferences: true)
    //        }
    //    }
    
    
    @objc func dismissRideListView() {
        dismiss(animated: true, completion: nil)
    }
}

private extension RideListViewController {
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, RideModel> {
        
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, rideModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierRideListCell, for: indexPath) as! RideListCell
                cell.dateTimeLabel.text = rideModel.dateTime
                cell.lengthRide.text = rideModel.lengthRide
                cell.fromLocationTextLabel.text = rideModel.fromPlace
                cell.toLocationTextLabel.text = rideModel.toPlace
                return cell
        }
        )
    }
}

extension RideListViewController {
    func update(with list: RideList, animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RideModel>()
        snapshot.appendSections([1,2,3])
        snapshot.appendItems(list.rideList, toSection: 1)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}



