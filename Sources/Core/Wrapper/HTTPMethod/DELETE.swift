//
//  DELETE.swift
//  RaAPIWrapper
//
//  Created by Rakuyo on 2022/12/15.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - DeleteHTTPMethod

public enum DeleteHTTPMethod: APIHTTPMethodWrapper {
    public static var httpMethod: APIHTTPMethod { "DELETE" }
}

/// Encapsulates the data needed to request the `DELETE` api.
public typealias DELETE<Parameter> = API<Parameter, DeleteHTTPMethod>
