//
//  ProductsServiceType.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//

import Foundation
import Combine

typealias ProductsResponse = AnyPublisher<[Product], Error>

// MARK: - Dependency
protocol HasProductsService {
    var productsService: ProductsServiceType { get set }
}

// MARK: - Products Service Type
protocol ProductsServiceType {
    func fetchProducts() -> ProductsResponse
}

// MARK: - Service Implementation
struct ProductsService: ProductsServiceType {
    typealias Dependencies = HasNetworkManager

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func fetchProducts() -> ProductsResponse {
        dependencies
            .networkManager
            .execute(on: ProductsTarget.products, decoder: .init())
            .eraseToAnyPublisher()
    }
}

// MARK: - Service Dependencies
struct ProductsServiceDependencies: HasNetworkManager {
    var networkManager: NetworkManagerType = NetworkManager(requester: URLSession.shared)
}
