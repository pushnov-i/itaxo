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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        configureNavigationBar()
    }
    
    // MARK - Handlers
    @objc func handleMenu() {
        delegate?.handleMenu()
        print("Menu")
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Drawer Menu"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal) , style: .done, target: self, action: #selector(handleMenu))
    }
    
    
}
