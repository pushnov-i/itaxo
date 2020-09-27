//
//  TextAttributes.swift
//  itaxo
//
//  Created by Illia Pushnov on 27.09.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit


struct TextAttributes {
    static func withFont(_ attribute: Font) -> [NSAttributedString.Key : Any] {
        return [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: attribute.size)
        ]
    }
}
