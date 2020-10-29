//
//  MenuOption.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

enum MenuOption: Int,CustomStringConvertible {
    
    case Trips // "Мої поїздки"
    case Payment // "Оплата"
    case Help // "Допомога"
    case AboutService // "Про сервіс"
    case EcoProjects // "Еко-проекти"
    case Partners // "Партнери"
    case DriverRegistration // "Реєстрація водія"
    case MapOfGasStation // "Карта заправок"
    
    var description: String {
        switch self {
        case .Trips: return "Мої поїздки"
        case .Payment: return "Оплата"
        case .Help: return "Допомога"
        case .AboutService: return "Про сервіс"
        case .EcoProjects: return "Еко-проекти"
        case .Partners: return "Партнери"
        case .DriverRegistration: return "Реєстрація водія"
        case .MapOfGasStation: return "Карта заправок"
        }
    }
    
    var image: UIImage {
        switch self {
        case .Trips: return UIImage(named: "logo") ?? UIImage()
        case .Payment:return UIImage(named: "logo") ?? UIImage()
        case .Help: return UIImage(named: "logo") ?? UIImage()
        case .AboutService: return UIImage(named: "logo") ?? UIImage()
        case .EcoProjects: return UIImage(named: "logo") ?? UIImage()
        case .Partners: return UIImage(named: "logo") ?? UIImage()
        case .DriverRegistration: return UIImage(named: "logo") ?? UIImage()
        case .MapOfGasStation: return UIImage(named: "logo") ?? UIImage()
        }
    }
    
    
}

