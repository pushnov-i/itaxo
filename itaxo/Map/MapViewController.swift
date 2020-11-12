//
//  MapViewController.swift
//  itaxo
//
//  Created by Illia Pushnov on 28.09.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import RxSwift
import GoogleMaps
import RxGoogleMaps
import SnapKit

class MapViewController: UIViewController, GMSMapViewDelegate {

    let isHidden = BehaviorSubject<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    let menuButton : UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "main/drawerbtn"), for: .normal)
        return view
    }()
    
    let overlay: UIView = {
        let view = UIView()
        view.layer.opacity = 0.8
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self
        self.view.addSubview(mapView)
        view.isUserInteractionEnabled = true
        
        isHidden.subscribe(onNext:  { [weak self] isHidden in
            guard let strongSelf = self else { return }
            strongSelf.overlay.isHidden = !isHidden
        })

        .disposed(by: self.disposeBag)


        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(23)
            make.top.equalTo(view).offset(23)
            make.height.equalTo(45)
            make.width.equalTo(45)
            
        }
        
        mapView.addSubview(overlay)
        
        overlay.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        mapView.rx.didTapAt.asDriver()
                 .drive(onNext: { print("Did tap at coordinate: \($0)") })
                 .disposed(by: disposeBag)
  }
    
}
