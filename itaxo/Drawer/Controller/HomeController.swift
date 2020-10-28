//
//  HomeController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    

//MARK: - Properties
    var delegate: HomeControllerDelegate?
// MARK - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#FFDE43ff")
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal) , style: .plain, target: self, action: #selector(handleMenu))
    }
    

}
