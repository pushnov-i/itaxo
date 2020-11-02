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
        view.backgroundColor = UIColor(hex: "#FFDE43ff")
        configureMenuController()
        configureHomeController()
    }
    
    // MARK - Handlers
    
    func configureHomeController() {
        let homeController = HomeController()
        homeController.delegate = self 
        centerController = UINavigationController(rootViewController: homeController)
        self.centerController.view.frame.origin.y = 30
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            //add our menu controller
            menuController = MenuController()
            self.menuController.view.frame.origin.y = 30
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    /// Perform animation for showing and  folding drawer view
    func showMenuController(shouldExpand:Bool) {
        if shouldExpand {
            //show Drawer menu
           // configureHomeController()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                self.centerController.view.frame.origin.y = 30
                self.centerController.view.alpha = 0.8
            }, completion: nil)
        } else {
            //hide Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                self.centerController.view.frame.origin.y = 30
                self.centerController.view.alpha = 1
            }, completion: nil)
        }
    }
}

extension ContainerController: HomeControllerDelegate {
    
    //handlemenu is responseble for state 
    func handleMenu() {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
    
    
}
