//
//  URLRequest+prepareRequest.swift
//  AccNetworkProvider
//
//  Created by Onur Hüseyin Çantay on 9.07.2019.
//  Copyright © 2019 Onur Hüseyin Çantay. All rights reserved.
//

import Foundation

internal extension URLRequest {
    
    mutating func prepareRequest(with target: NetworkTarget) {
            let contentTypeHeaderName = "Content-Type"
            setValue(target.contentType?.rawValue, forHTTPHeaderField: contentTypeHeaderName)
            httpMethod = target.methodType.methodName
    }
    
}
