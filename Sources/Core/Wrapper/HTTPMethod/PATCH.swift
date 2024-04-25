//
//  PATCH.swift
//  RaAPIWrapper
//
//  Created by Rakuyo on 2022/12/15.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - PatchHTTPMethod

public enum PatchHTTPMethod: APIHTTPMethodWrapper {
    public static var httpMethod: APIHTTPMethod { "PATCH" }
}

/// Encapsulates the data needed to request the `PATCH` api.
public typealias PATCH<Parameter> = API<Parameter, PatchHTTPMethod>
