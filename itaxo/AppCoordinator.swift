//
//  AppCoordinator.swift
//  itaxo
//
//  Created by Illia Pushnov on 28.09.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}


//class AppCoordinator: Coordinator {
//    var navigationController: UINavigationController
//    
//    func start() {
//    }
//    
//    
//}
