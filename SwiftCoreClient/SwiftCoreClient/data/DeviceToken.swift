//
//  DeviceToken.swift
//
//  Created by azharkova on 24.01.2018.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import Foundation
import Alamofire

struct DeviceToken: Codable {
    var deviceToken: String=""
    var parametersRepresentation: Parameters {
        return ["deviceToken":deviceToken]
    }

    static let key = "device_token"

}
