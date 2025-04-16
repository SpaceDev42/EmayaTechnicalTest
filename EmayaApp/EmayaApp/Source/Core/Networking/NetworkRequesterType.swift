//
//  NetworkRequesterType.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import Foundation

// MARK: - Network Requester Protocols
protocol NetworkRequesterType {
    func requestData<T: Codable>(for target: EmayaServicesTargetType,with decoder: JSONDecoder) -> AnyPublisher<T, Error>
}

// MARK: - URLSession Extension
extension URLSession: NetworkRequesterType {
    private func buildURLRequest(for target: EmayaServicesTargetType) -> URLRequest? {
        guard let url = target.url else { return nil }

        var request = URLRequest(url: url)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer " + Constant.accessToken, forHTTPHeaderField: "Authorization")

        request.httpMethod = target.method.rawValue
        request.httpBody = target.body

        return request
    }

    /// This method request using Combine
    func requestData<T: Decodable>(
        for target: EmayaServicesTargetType,
        with decoder: JSONDecoder
    ) -> AnyPublisher<T, Error> {
        guard let request = buildURLRequest(for: target) else {
            return Empty().eraseToAnyPublisher()
        }

        // MARK: - Combine Implementation
        return dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode)
                else {
                    return data
                }

                return data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
