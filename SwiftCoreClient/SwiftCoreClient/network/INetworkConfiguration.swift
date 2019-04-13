//
//  INetworkConfiguration.swift

//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation

protocol INetworkConfiguration: class {
    var token: String? {get }
    var refreshToken: String? {get}
    var appVersion: String? {get set}
    var systemVersion: String {get set}
    var timeDiff: Int {get set}
    func refreshToken(refreshToken: String)
    func setToken(token: String)
    func getHeaders() -> [String: String]
    func getBaseUrl() -> String
    func getSecretCredentials() -> [String: String]
    func getHeadersWithVersion(version: Int) -> [String: String]

}
