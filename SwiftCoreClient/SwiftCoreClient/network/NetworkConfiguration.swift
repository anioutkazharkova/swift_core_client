//
//  NetworkConfiguration.swift
//  MoviesSearch
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit

class NetworkConfiguration: INetworkConfiguration {

    private let defaultVersion: Int = 1
    private var client_id: String = ""
    private var client_secret: String = ""
    private let url: String = ""

    var token: String?
    var refreshToken: String?

    private let apiUrl = (Bundle.main.object(forInfoDictionaryKey: "API_WEB_URL") as? String) ?? ""
    var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var systemVersion = UIDevice.current.systemVersion
    var timeDiff = NSInteger(TimeInterval(NSTimeZone.local.secondsFromGMT()))/3600

    func getHeaders() -> [String: String] {
        var headers = ["X-Mobile-Platform-Version":"iOS \(systemVersion)",
            "X-Mobile-Application-Version":"iOS \(appVersion ?? " ")",
            "Content-Type":"application/json",
            "X-Client-Id":client_id,
            "X-Client-Timezone":"\(timeDiff)"]
        if (!(token ?? "").isEmpty()) {
            headers["Authorization"] = "Bearer \(token ?? "")"
        }
        return headers
    }

    func getHeadersWithVersion(version: Int) -> [String: String] {

        var headers = getHeaders()
        headers["X-Api-Version"] = "\(version)"

        return headers
    }
    
    func getBaseUrl() -> String {
        return "\(apiUrl)"
    }

    func getSecretCredentials() -> [String: String] {
        return ["client_id": client_id,
               "client_secret": client_secret]
    }

    func setToken(token: String) {
        self.token = token
    }

    func refreshToken(refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
