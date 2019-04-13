//
//  ErrorResponse.swift
//  MoviesSearch
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit
import ObjectMapper

class ErrorResponse_: Mappable {
    var status: String?
    var message: String?
    var code: String?
    var errorType: ErrorType = .other

    init() {}
    required init?(map: Map) {}
    convenience init(type: ErrorType) {
        self.init()
        self.errorType = type
    }

    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        code <- map["code"]
    }
}
