import Foundation

import APIWrapper

/// Before formally defining the api, we need to encapsulate a method for requesting the api.
///
/// The role of `RaAPIWrapper` is to encapsulate the parameters needed to request the api,
/// so we don't add any logic for requesting the api.
///
/// This part of the logic needs to be implemented by you in your own project,
/// for now we provide a simple implementation:

extension API {
    /// Request an api **with parameters** and resolve the api return value to a `T` type.
    ///
    /// - Parameters:
    ///     - params: api parameters.
    ///     - type: the type of the api return value.
    /// - Returns: The result of the parsing.
    public func request<T: Decodable>(with params: Parameter, to type: T.Type) async throws -> T {
        let data = try await _request(with: params)
        return try JSONDecoder().decode(type, from: data)
    }

    /// Request an api **without** parameters.
    ///
    /// This method means: the requesting party does not need the parameters returned by the api,
    /// so no return value is provided.
    ///
    /// - Parameter params: api parameters.
    public func request(with params: Parameter) async throws {
        _ = try await _request(with: params)
    }
}

/// For some api that do not require parameters,
/// we can also provide the following methods to make the request process even simpler.

extension API where Parameter == Void {
    /// Request an api **without** parameters and resolve the api return value to a `T` type.
    ///
    /// - Parameter type: The type of the api's return value.
    /// - Returns: The result of the parsing.
    public func request<T: Decodable>(to type: T.Type) async throws -> T {
        try await request(with: (), to: type)
    }

    /// Request an api **without** parameters.
    ///
    /// This method means: the requesting party does not need the parameters returned by the api,
    /// so no return value is provided.
    public func request() async throws {
        try await request(with: ())
    }
}

// MARK: - Tools

extension API {
    private func _request(with params: Parameter) async throws -> Data {
        let info = createRequestInfo(params)

        // To simplify the demo process, here is a forced unpacking
        guard let url = URL(string: "https://postman-echo.com" + info.path) else {
            fatalError("url(\(info.path) nil!")
        }

        Log.log("▶️ Requests will begin soon: \(url.absoluteString)")

        var request = URLRequest(url: url)
        request.httpMethod = info.httpMethod.rawValue

        if let parameters = info.parameters {
            Log.log("🚧 parameters: \(parameters)")
            request.httpBody = try JSONEncoder().encode(parameters)

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        Log.log("✅ \(response.url?.absoluteString ?? "nil") End of request")

        return data
    }
}
