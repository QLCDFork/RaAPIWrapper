//
//  GET.swift
//  RaAPIWrapper
//
//  Created by Rakuyo on 2022/8/26.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - GetHTTPMethod

public enum GetHTTPMethod: APIHTTPMethodWrapper {
    public static var httpMethod: APIHTTPMethod { "GET" }
}

/// Encapsulates the data needed to request the `GET` api.
public typealias GET<Parameter> = API<Parameter, GetHTTPMethod>
