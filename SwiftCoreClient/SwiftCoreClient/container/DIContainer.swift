//
//  DIContainer.swift

//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

protocol IDIContainer {
    var networkService: INetworkService { get }
    var networkConfig: INetworkConfiguration { get }
    var authManager: IAuthManager {get}
}

class DIContainer: IDIContainer {
    private var _networkService: INetworkService?
    private var _networkConfig: INetworkConfiguration?
    private var _authManager: IAuthManager?

    var networkService: INetworkService {
        if (_networkService == nil) {
            _networkService = NetworkService(networkConfiguration: DI.container.networkConfig)
        }
        return _networkService!
    }
    var networkConfig: INetworkConfiguration {
        if (_networkConfig == nil ) {
             _networkConfig = NetworkConfiguration()
        }
        return _networkConfig!
    }

    var authManager: IAuthManager {
        if (_authManager == nil) {
            _authManager = AuthManager()
        }
        return _authManager!
    }

}
