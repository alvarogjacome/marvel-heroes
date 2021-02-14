//
//  UIColor+.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 14/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ asset: Colors) {
        self.init(named: asset.rawValue)!
    }
}
