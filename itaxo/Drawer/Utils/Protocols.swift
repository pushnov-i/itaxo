//
//  Protocols.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
import UIKit

protocol HomeControllerDelegate: class {
    func handleMenu()
}

protocol MenuOptionRepresentable {
    var description: String { get }
    var image: String { get }
}
