//
//  SimpleResponse.swift
//   
//
//   Created by azharkova on 27.02.2019.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import UIKit
import ObjectMapper

class SimpleResponse: Mappable {
    var isSuccess: Bool = false

    init() {}
    convenience init(isSuccess: Bool) {
        self.init()
        self.isSuccess = isSuccess
    }

    required init?(map: Map) {}

    func mapping(map: Map) {}
}
