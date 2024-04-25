//
//  OPTIONS.swift
//  RaAPIWrapper
//
//  Created by Rakuyo on 2022/12/15.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - OptionsHTTPMethod

public enum OptionsHTTPMethod: APIHTTPMethodWrapper {
    public static var httpMethod: APIHTTPMethod { "OPTIONS" }
}

/// Encapsulates the data needed to request the `OPTIONS` api.
public typealias OPTIONS<Parameter> = API<Parameter, OptionsHTTPMethod>
