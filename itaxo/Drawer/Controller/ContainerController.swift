//
//  ContainerController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    
    //MARK: - Properties
    
    var menuController: UIViewController! // for one time adding menuController
    var centerController: UIViewController!
    var isExpanded = false
    
    // MARK - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    // MARK - Handlers
    
    func configureHomeController() {
        let homeController = HomeController()
        homeController.delegate = self 
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            //add our menu controller
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    /// Perform animation for showing and  folding drawer view
    func showMenuController(shouldExpand:Bool) {
        if shouldExpand {
            //show Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80}, completion: nil)
        } else {
            //hide Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {self.centerController.view.frame.origin.x = 0}, completion: nil)
        }
    }
    
}

extension ContainerController: HomeControllerDelegate {
    func handleMenu() {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
    
    
}
