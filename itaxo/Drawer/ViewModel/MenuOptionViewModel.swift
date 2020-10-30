//
//  MenuOption.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

enum menuOption: Int {
    
    
    case Trips // "Мої поїздки"
    case Payment // "Оплата"
    case Help // "Допомога"
    case AboutService // "Про сервіс"
    case EcoProjects // "Еко-проекти"
    case Partners // "Партнери"
    case DriverRegistration // "Реєстрація водія"
    case MapOfGasStation // "Карта заправок"
}
//TODO Section view

enum userCredentials: Int {
    case name
    case surname
}

struct MenuOptionViewModel : MenuOptionRepresentable {
    var image: String{
        switch menuOption.self {
        case .Trips: return  "arrows icon"
        case .Payment:return "card icon"
        case .Help: return "help icon"
        case .AboutService: return "Info icon"
        case .EcoProjects: return "leaf icon"
        case .Partners: return "handshake icon"
        case .DriverRegistration: return "driver icon"
        case .MapOfGasStation: return "petroil station icon"
        }
    }
    

    
    let menuOption : menuOption
    
    var description: String {
        switch menuOption {
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
}





