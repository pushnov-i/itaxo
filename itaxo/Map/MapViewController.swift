//
//  MapViewController.swift
//  itaxo
//
//  Created by Illia Pushnov on 28.09.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import GoogleMaps
import SnapKit

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    
    let menuButton : UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "main/drawerbtn"), for: .normal)
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
        
    
        
  }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("asdasd")
    }
    
}
