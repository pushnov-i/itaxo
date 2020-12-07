//
//  RideListViewController.swift
//  itaxo
//
//  Created by Genuine on 25.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit
import CoreData


var rides: [NSManagedObject] = []

var rideNew : [Drive] = []
var driveLeanth : [String?] = []

class RideListViewController :  UICollectionViewController,
UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifierRideListCell = "rideListCell"
    let headerIdentifier = "rideListHeaderView"
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        configureHeader()
        configureCollectionView()
        
        //Testing CoreData exchange
        self.getRides()
        self.save(dateTime: "13.05.2020, 18:15",
                  lengthRide: "12.3 км",
                  fromPlace: "Київ, вул. Бойчука Михайла 46",
                  toPlace: "Київ, вул. Глибочицька 79",
                  price: "103")
        self.save(dateTime: "13.05.2020, 18:15",
                  lengthRide: "12.3 км",
                  fromPlace: "Київ, вул. Бойчука Михайла 46",
                  toPlace: "Київ, вул. Глибочицька 79",
                  price: "104")
        self.save(dateTime: "13.05.2020, 18:15",
                  lengthRide: "12.3 км",
                  fromPlace: "Київ, вул. Бойчука Михайла 46",
                  toPlace: "Київ, вул. Глибочицька 79",
                  price: "105")
        print(driveLeanth)
    }
    
    
    func configureCollectionView() {
        
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 200)
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 100)
        collectionView = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RideListCell.self,
                                forCellWithReuseIdentifier: reuseIdentifierRideListCell)
        collectionView.register(RideListHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: headerIdentifier)
        collectionView.backgroundColor = .white
        collectionView.dataSource = dataSource
        view.backgroundColor = yellowBackground
        collectionView.snp.makeConstraints{(make) -> Void in
            
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.top.equalTo( self.view.safeAreaLayoutGuide.snp.topMargin).inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
        }
        update(with: RideList())
    }
    
    func configureHeader() {
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            let header: RideListHeaderView = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: self.headerIdentifier,
                                                  for: indexPath) as! RideListHeaderView
            //            header.snp.makeConstraints{(make) -> Void in
            //                make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            //            }
            return header
        }
    }
    
    struct RideModel: Hashable {
        let dateTime: String
        let lengthRide: String
        let fromPlace : String
        let toPlace : String
        let price : String
    }
    
    struct RideList {
        var rideList : [RideModel] = [
            RideModel(dateTime: "13.05.2020, 17:25",
                      lengthRide: "11.1 км",
                      fromPlace: "Київ, Гагаріна Юрія проспект, 20",
                      toPlace: "Київ, Парк Дружби народів",
                      price: "106")
        ]
        //            {
        //            set(newRide){
        //
        //            }
        //        }
    }
    
    
    @objc func dismissRideListView() {
        dismiss(animated: true, completion: nil)
    }
}

private extension RideListViewController {
    func makeDataSource() -> UICollectionViewDiffableDataSource<Int, RideModel> {
        
        return UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, rideModel) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifierRideListCell,
                                                              for: indexPath) as! RideListCell
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
    func update(with list: RideList, animate: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RideModel>()
        snapshot.appendSections([1])
        snapshot.appendItems(list.rideList, toSection: 1)
        snapshot.appendItems([getRides()], toSection: 1)
        self.dataSource.apply(snapshot,animatingDifferences: animate)
    }
    @available(iOS 13.0, *)
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        guard let dataSource = collectionView?.dataSource as? UICollectionViewDiffableDataSourceReference else {
            fatalError("The data source has not implemented snapshot support while it should")
        }
        dataSource.applySnapshot(snapshot, animatingDifferences: true)
    }
}
extension RideListViewController {
    func save(dateTime: String, lengthRide: String, fromPlace: String, toPlace: String, price: String) {
        let drive = CoreDataManager.sharedManager.insertRideModel(dateTime: dateTime,
                                                                  lengthRide: lengthRide,
                                                                  fromPlace: fromPlace,
                                                                  toPlace: toPlace,
                                                                  price: price)
        if drive != nil {
            rides.append(drive!)//3
        }
    }
    
    func getRides()->RideModel {
        let drive = CoreDataManager.sharedManager.getRideModel()
        
            let ride = RideModel(dateTime: drive!.date, lengthRide: drive!.distance, fromPlace: drive!.from, toPlace: drive!.to, price: drive!.paiment_id)
            print(ride)
            return ride
            //  driveLeanth.append(drive?.distance)
            //   rideNew.append(drive!)
            
        
    }
}


