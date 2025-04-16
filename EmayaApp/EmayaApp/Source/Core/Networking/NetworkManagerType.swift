//
//  NetworkManagerType.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import Foundation
import Combine

// MARK: -  Network Manager Dependency
protocol HasNetworkManager {
    var networkManager: NetworkManagerType { get set }
}

// MARK: - Network Manager Protocols
protocol NetworkManagerType {
    func execute<T: Codable>(on target: EmayaServicesTargetType, decoder: JSONDecoder) -> AnyPublisher<T, Error>
}

class NetworkManager: NetworkManagerType {
    private let requester: NetworkRequesterType

    init(requester: NetworkRequesterType = URLSession.shared) {
        self.requester = requester
    }

    // MARK: - Execute Network Request
    func execute<T: Codable>(
        on target: EmayaServicesTargetType,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        requester.requestData(for: target, with: decoder)
    }
}
