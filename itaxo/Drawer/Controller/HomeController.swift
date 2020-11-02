//
//  HomeController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    weak var delegate: HomeControllerDelegate?
    var mapView = UIView()

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
        view.addSubview(mapView)
        
    }
}
