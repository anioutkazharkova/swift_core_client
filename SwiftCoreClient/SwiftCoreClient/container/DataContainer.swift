//
//  ServiceContainer.swift
//  MoviesSearch
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation

protocol  IDataContainer {
   var storage: Storage {get }
    var authStorage: AuthStorage {get}
}

class  DataContainer: IDataContainer {
    private var _storage: Storage?
    private var _authStorage: AuthStorage?

    var storage: Storage {
        if (_storage == nil) {
            _storage = Storage()
        }
        return _storage!
    }

    var authStorage: AuthStorage {
        if (_authStorage == nil) {
        _authStorage = AuthStorage()
        }
        return _authStorage!
    }

}
