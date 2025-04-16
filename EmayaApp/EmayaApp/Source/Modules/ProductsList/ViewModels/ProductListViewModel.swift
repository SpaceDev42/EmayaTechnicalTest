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
    @Published var filteredProducts: [Product] = []
    @Published var errorMessage: String?
    @Published var productSearch: String = ""
    @Published var isLoading: Bool = false
    @Published var isPresentingProductDetail: Bool = false

    private let dependencies: Dependencies
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Init
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        setUp()
    }

    // MARK: - Set Up
    func setUp() {
        setupBindings()
        fetchProducts()
    }

    // MARK: - Set Up Bindings
    private func setupBindings() {
        $productSearch
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .combineLatest($products)
            .map { searchText, products in
                guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    return products
                }

                return products.filter { product in
                    product.title.lowercased().contains(searchText.lowercased())
                }
            }
            .assign(to: \.filteredProducts, on: self)
            .store(in: &cancellables)
    }

    // MARK: - Fetch Products
    private func fetchProducts() {
        dependencies
            .productsService
            .fetchProducts()
            .handleEvents(receiveRequest: { [weak self] _ in self?.isLoading = true })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                guard case let .failure(error) = completion else { return }
                print(error)
                self?.errorMessage = "Se produjo un error intente nuevamente"
                self?.isPresentingAlert = true
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.filteredProducts = products
            }
            .store(in: &cancellables)
    }
}

// MARK: - Dependencies
struct ProductsListViewModelDependencies: HasProductsService {
    var productsService: ProductsServiceType = ProductsService(dependencies: ProductsServiceDependencies())
}
