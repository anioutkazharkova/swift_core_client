//
//  DI.swift
//  MoviesSearch
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit

public class DI {
private static let shared = DI()

static var container: IDIContainer {
    return shared.container
}

    static var dataContainer: IDataContainer {
        return shared.dataContainer
    }
    static var serviceContainer: IServiceContainer {
        return shared.serviceContainer
    }

private let container: IDIContainer
    private let dataContainer: IDataContainer
    private let serviceContainer: IServiceContainer

init() {
    container = DIContainer()
   dataContainer = DataContainer()
    serviceContainer = ServiceContainer()

}

}
