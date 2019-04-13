//
//  String+Utile.swift
//  SwiftCoreClient
//
//   Created by azharkova on 14.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

extension String {
    func isEmpty() -> Bool {
        guard  self.count > 0 else {
            return true
        }
        return false
}
}
