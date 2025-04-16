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
    @Published var selectedProduct: Product = .empty
    @Published var selectedCategory: Category?

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
        Publishers.CombineLatest3(
            $productSearch
                .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
                .removeDuplicates(),
            $selectedCategory,
            $products
        )
        .map { searchText, category, products in
            var result = products

            if let category = category {
                result = result.filter { $0.category == category }
            }

            let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

            if !trimmed.isEmpty {
                result = result.filter {
                    $0.title.lowercased().contains(trimmed.lowercased())
                }
            }

            return result
        }
        .receive(on: DispatchQueue.main)
        .assign(to: \.filteredProducts, on: self)
        .store(in: &cancellables)

        $selectedProduct
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] product in
                self?.updateProduct(product)
            }
            .store(in: &cancellables)

        $selectedCategory
            .receive(on: DispatchQueue.main)
            .sink { [weak self] category in
                guard let self, let category else {
                    self?.syncProductsList()
                    self?.filteredProducts = self?.products ?? []
                    return
                }

                self.filteredProducts = self.products.filter { $0.category == category }
            }
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
                self?.errorMessage = "Se produjo un error intente nuevamente"
                self?.isPresentingAlert = true
            } receiveValue: { [weak self] products in
                self?.products = products
                self?.filteredProducts = products
            }
            .store(in: &cancellables)
    }

    // MARK: - Sync Products
    private func syncProductsList() {
        filteredProducts.forEach { product in
            if let index = products.firstIndex(where: { $0.id == product.id }) {
                products[index] = product
            }
        }
    }

    // MARK: - Select product
    func presentProduct(_ selection: Product) {
        selectedProduct = selection
        isPresentingProductDetail = true
    }

    // MARK: - Update Product
    func updateProduct(_ selection: Product) {
        if let filteredIndex = filteredProducts.firstIndex(where: { $0.id == selection.id }) {
            filteredProducts[filteredIndex] = selection
        }

        syncProductsList()
    }

    // MARK: - Select Category
    func selectCategory(_ option: Category) {
        guard option != .none else {
            selectedCategory = nil
            return
        }

        selectedCategory = option
    }
}

// MARK: - Dependencies
struct ProductsListViewModelDependencies: HasProductsService {
    var productsService: ProductsServiceType = ProductsService(dependencies: ProductsServiceDependencies())
}
