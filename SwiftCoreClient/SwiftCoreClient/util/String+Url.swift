//
//  String+Url.swift
//  SwiftCoreClient
//
//   Created by azharkova on 14.04.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation
extension String {
    var encodeUrl: String {
        return escape(string: self) //self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl: String {
        return self.removingPercentEncoding!
    }

    public func escape(string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        let allowedCharacterSet = NSCharacterSet.urlQueryAllowed as! NSMutableCharacterSet
        allowedCharacterSet.removeCharacters(in: generalDelimitersToEncode + subDelimitersToEncode)
        let unreserved = "-._~/?"
        var escaped = ""
        allowedCharacterSet.addCharacters(in: unreserved)
        escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet) ?? string

        return escaped
    }

}
