//
//  TokenResponse.swift
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenResponse: Mappable {

    var token: String?
    var refreshToken: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        token <- map["access_token"]
        refreshToken <- map["refresh_token"]
    }

}
