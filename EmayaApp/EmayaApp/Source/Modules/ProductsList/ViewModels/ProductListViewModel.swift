//
//  ProductListViewModel.swift
//  EmayaApp
//
//  Created by Vladimir Guevara on 15/4/25.
//
import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    typealias Dependencies = HasProductsService

    // MARK: - Properties
    @Published var isPresentingAlert: Bool = false
    @Published var products: [Product] = []
    @Published var errorMessage: String?
    @Published var productSearch: String = ""

    private let dependencies: Dependencies
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        setUp()
    }

    // MARK: - Set Up
    func setUp() {
        fetchProducts()
    }

    // MARK: - Fetch Products
    private func fetchProducts() {
        dependencies
            .productsService
            .fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                print(error)
                self?.errorMessage = "Se produjo un error intente nuevamente"
                self?.isPresentingAlert = true
            } receiveValue: { [weak self] products in
                self?.products = products
            }
            .store(in: &cancellables)
    }
}

// MARK: - Dependencies
struct ProductsListViewModelDependencies: HasProductsService {
    var productsService: ProductsServiceType = ProductsService(dependencies: ProductsServiceDependencies())
}
