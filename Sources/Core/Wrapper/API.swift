//
//  API.swift
//  RaAPIWrapper
//
//  Created by Rakuyo on 2022/8/25.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - APIHTTPMethodWrapper

/// Used to encapsulate the `APIHTTPMethod` object provided to the `API`.
public protocol APIHTTPMethodWrapper {
    static var httpMethod: APIHTTPMethod { get }
}

// MARK: - API

/// API wrapper. Used to wrap the data needed to request an api.
@propertyWrapper
public class API<Parameter, HTTPMethod: APIHTTPMethodWrapper> {
    public typealias HeaderBuilder = (Parameter) -> APIHeaders

    public typealias ParameterBuilder = APIParameterBuilder<Parameter>

    /// Enables you to access `@propertyWrapper` objects via the `$` symbol.
    public var projectedValue: API<Parameter, HTTPMethod> { self }

    /// Parameter constructor for the api.
    public var wrappedValue: ParameterBuilder?

    /// A special api base url.
    ///
    /// Should be a setting item independent of your global configuration.
    public let specialBaseURL: URL?

    /// The path to the requested api.
    public let path: String

    /// Used to construct the api request header.
    public let headerBuilder: HeaderBuilder?

    /// An additional storage space.
    /// You can use this property to store some custom data.
    public let userInfo: APIRequestUserInfo

    public init(
        wrappedValue: ParameterBuilder?,
        _ path: String,
        specialBaseURL: URL? = nil,
        header: HeaderBuilder? = nil,
        userInfo: APIRequestUserInfo = [:]
    ) {
        self.wrappedValue = wrappedValue
        self.path = path
        self.specialBaseURL = specialBaseURL
        headerBuilder = header
        self.userInfo = userInfo
    }
}

extension API {
    /// The HTTP method to use when requesting the api.
    ///
    /// Open this property so that you can access the request method
    /// directly through the `@propertyWrapper` object.
    public static var httpMethod: HTTPMethod.Type { HTTPMethod.self }

    /// Creates an `APIRequestInfo` object.
    ///
    /// Used to generate the final, minimal api data.
    public func createRequestInfo(_ parameter: Parameter) -> APIRequestInfo {
        .init(
            path: path,
            specialBaseURL: specialBaseURL,
            httpMethod: Self.httpMethod.httpMethod,
            header: headerBuilder?(parameter),
            parameterBuild: wrappedValue,
            parameterInput: parameter,
            userInfo: userInfo
        )
    }
}
