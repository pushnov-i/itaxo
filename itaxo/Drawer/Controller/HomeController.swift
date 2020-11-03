//
//  HomeController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    weak var delegate: HomeControllerDelegate?
    var mapView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeController()
    }
    
    // MARK - Handlers
    @objc func handleMenu() {
        delegate?.handleMenu()
        print("MenuTap")
    }
    
    func configureHomeController() {

        view.backgroundColor = .darkGray
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMenu))
        view.addGestureRecognizer(tap)
        let mapViewController = MapViewController()
        
        // добавляем на подложку мап вью контроллер
        
        mapView = mapViewController.view
        if let mapView = mapViewController.view {
            addChild(mapViewController)
            view.addSubview(mapViewController.view)
            mapView.didMoveToWindow()
            
            mapView.snp.makeConstraints { maker in
                maker.edges.equalTo(view)
            }
        }
        
        
    }
}
